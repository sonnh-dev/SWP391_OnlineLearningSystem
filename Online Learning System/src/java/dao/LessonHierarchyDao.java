package dao;

import context.context2;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LessonHierarchyDao extends context2 {

    public static class LessonItem {
        private int id;
        private String name;
        private int order;
        private String type;
        private boolean status;

        public LessonItem(int id, String name, int order, String type, boolean status) {
            this.id = id;
            this.name = name;
            this.order = order;
            this.type = type;
            this.status = status;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public int getOrder() { return order; }
        public String getType() { return type; }
        public boolean isStatus() { return status; }
    }

    public List<LessonItem> getLessonHierarchyBySubjectId(int courseId) {
        List<LessonItem> items = new ArrayList<>();

        try (Connection conn = getConnection()) {
            String sqlChapter = "SELECT ChapterID, Title, ChapterOrder, Status FROM Chapter WHERE CourseID = ? ORDER BY ChapterOrder";
            PreparedStatement psChapter = conn.prepareStatement(sqlChapter);
            psChapter.setInt(1, courseId);
            ResultSet rsChapter = psChapter.executeQuery();

            while (rsChapter.next()) {
                int chapterId = rsChapter.getInt("ChapterID");
                String chapterTitle = rsChapter.getString("Title");
                int chapterOrder = rsChapter.getInt("ChapterOrder");
                boolean chapterStatus = rsChapter.getObject("Status") != null && rsChapter.getBoolean("Status");

                items.add(new LessonItem(chapterId, chapterTitle, chapterOrder, "Subject Topic", chapterStatus));

                String sqlLesson = "SELECT LessonID, Title, LessonOrder, Status FROM Lesson WHERE ChapterID = ? ORDER BY LessonOrder";
                PreparedStatement psLesson = conn.prepareStatement(sqlLesson);
                psLesson.setInt(1, chapterId);
                ResultSet rsLesson = psLesson.executeQuery();

                while (rsLesson.next()) {
                    int lessonId = rsLesson.getInt("LessonID");
                    String lessonTitle = rsLesson.getString("Title");
                    int lessonOrder = rsLesson.getInt("LessonOrder");
                    boolean lessonStatus = rsLesson.getObject("Status") != null && rsLesson.getBoolean("Status");

                    items.add(new LessonItem(lessonId, "– " + lessonTitle, lessonOrder, "Lesson", lessonStatus));

                    String sqlQuiz = "SELECT QuizID, QuizName, QuestionOrder, Status FROM Quizzes WHERE LessonID = ? ORDER BY QuestionOrder";
                    PreparedStatement psQuiz = conn.prepareStatement(sqlQuiz);
                    psQuiz.setInt(1, lessonId);
                    ResultSet rsQuiz = psQuiz.executeQuery();

                    while (rsQuiz.next()) {
                        int quizId = rsQuiz.getInt("QuizID");
                        String quizName = rsQuiz.getString("QuizName");
                        int quizOrder = rsQuiz.getObject("QuestionOrder") != null ? rsQuiz.getInt("QuestionOrder") : 0;
                        boolean quizStatus = rsQuiz.getObject("Status") != null && rsQuiz.getBoolean("Status");

                        items.add(new LessonItem(quizId, "– – " + quizName, quizOrder, "Quiz", quizStatus));
                    }

                    rsQuiz.close();
                    psQuiz.close();
                }

                rsLesson.close();
                psLesson.close();
            }

            rsChapter.close();
            psChapter.close();

            String sqlIndQuiz = "SELECT QuizID, QuizName, QuestionOrder, Status FROM Quizzes WHERE LessonID IS NULL AND CourseID = ? ORDER BY QuizID";
            PreparedStatement psIndQuiz = conn.prepareStatement(sqlIndQuiz);
            psIndQuiz.setInt(1, courseId);
            ResultSet rsIndQuiz = psIndQuiz.executeQuery();

            while (rsIndQuiz.next()) {
                int quizId = rsIndQuiz.getInt("QuizID");
                String quizName = rsIndQuiz.getString("QuizName");
                int quizOrder = rsIndQuiz.getObject("QuestionOrder") != null ? rsIndQuiz.getInt("QuestionOrder") : 0;
                boolean quizStatus = rsIndQuiz.getObject("Status") != null && rsIndQuiz.getBoolean("Status");

                items.add(new LessonItem(quizId, "** Independent Quiz: " + quizName, quizOrder, "Independent Quiz", quizStatus));
            }

            rsIndQuiz.close();
            psIndQuiz.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }

    public List<LessonItem> getFilteredLessonHierarchy(int courseId, String statusFilter, String searchKeyword, String lessonGroup) {
        List<LessonItem> allItems = getLessonHierarchyBySubjectId(courseId);
        List<LessonItem> filteredItems = new ArrayList<>();

        boolean filterActive = "active".equalsIgnoreCase(statusFilter);
        boolean filterInactive = "inactive".equalsIgnoreCase(statusFilter);
        boolean hasSearch = searchKeyword != null && !searchKeyword.trim().isEmpty();
        boolean hasGroup = lessonGroup != null && !lessonGroup.trim().isEmpty() && !"all".equalsIgnoreCase(lessonGroup);

        String keyword = hasSearch ? searchKeyword.trim().toLowerCase() : "";
        String groupFilter = hasGroup ? lessonGroup.trim().toLowerCase() : "";

        String currentGroup = "";

        for (LessonItem item : allItems) {
            if ("Subject Topic".equals(item.getType())) {
                currentGroup = item.getName().trim().toLowerCase(); // update chapter
            }

            boolean matchesGroup = !hasGroup || currentGroup.equals(groupFilter);
            boolean matchesStatus =
                "all".equalsIgnoreCase(statusFilter) ||
                (filterActive && item.isStatus()) ||
                (filterInactive && !item.isStatus());

            boolean matchesSearch =
                !hasSearch || item.getName().toLowerCase().contains(keyword);

            if (matchesGroup && matchesStatus && matchesSearch) {
                filteredItems.add(item);
            }
        }

        return filteredItems;
    }

    public String getSubjectName(int subjectId) {
        String name = "Unknown";
        try (Connection conn = getConnection()) {
            String sql = "SELECT CourseName FROM Course WHERE CourseID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("CourseName");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public List<String> getLessonGroups(int subjectId) {
        List<String> groups = new ArrayList<>();
        String sql = "SELECT DISTINCT Title FROM Chapter WHERE CourseID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                groups.add(rs.getString("Title"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return groups;
    }

    public void toggleStatus(int id, String type) {
        String sql = "";
        String column = "";

        switch (type) {
            case "Subject Topic":
                sql = "UPDATE Chapter SET Status = NOT Status WHERE ChapterID = ?";
                break;
            case "Lesson":
                sql = "UPDATE Lesson SET Status = NOT Status WHERE LessonID = ?";
                break;
            case "Quiz":
            case "Independent Quiz":
                sql = "UPDATE Quizzes SET Status = NOT Status WHERE QuizID = ?";
                break;
            default:
                return;
        }

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public model.Lesson getLessonById(int lessonId) {
        model.Lesson lesson = null;
        try (Connection conn = getConnection()) {
            String sql = "SELECT LessonID, ChapterID, Title, LessonOrder, Status, IsFree FROM Lesson WHERE LessonID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lesson = new model.Lesson();
                lesson.setLessonID(rs.getInt("LessonID"));
                lesson.setChapterID(rs.getInt("ChapterID"));
                lesson.setTitle(rs.getString("Title"));
                lesson.setLessonOrder(rs.getInt("LessonOrder"));
                lesson.setStatus(rs.getObject("Status") != null ? rs.getBoolean("Status") : null);
                lesson.setIsFree(rs.getObject("IsFree") != null ? rs.getBoolean("IsFree") : null);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lesson;
    }

    public model.LessonContent getLessonContentById(int lessonId) {
        model.LessonContent lessonContent = null;
        try (Connection conn = getConnection()) {
            String sql = "SELECT LessonID, VideoURL, DocContent FROM LessonContent WHERE LessonID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lessonContent = new model.LessonContent();
                lessonContent.setLessonID(rs.getInt("LessonID"));
                lessonContent.setVideoURL(rs.getString("VideoURL"));
                lessonContent.setDocContent(rs.getString("DocContent"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessonContent;
    }

    public boolean updateLesson(model.Lesson lesson) {
        boolean success = false;
        try (Connection conn = getConnection()) {
            String sql = "UPDATE Lesson SET Title = ?, ChapterID = ?, LessonOrder = ?, Status = ?, IsFree = ? WHERE LessonID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, lesson.getTitle());
            ps.setInt(2, lesson.getChapterID());
            ps.setInt(3, lesson.getLessonOrder());
            ps.setBoolean(4, lesson.getStatus() != null ? lesson.getStatus() : false);
            
            ps.setInt(6, lesson.getLessonID());
            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean updateLessonContent(model.LessonContent lessonContent) {
        boolean success = false;
        try (Connection conn = getConnection()) {
            String sql = "UPDATE LessonContent SET VideoURL = ?, DocContent = ? WHERE LessonID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, lessonContent.getVideoURL());
            ps.setString(2, lessonContent.getDocContent());
            ps.setInt(3, lessonContent.getLessonID());
            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}