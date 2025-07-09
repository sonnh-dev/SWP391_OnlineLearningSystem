CREATE database SWP391DB;

USE SWP391DB;

-- Bảng người dùng (Users)
CREATE TABLE Users (
    userID INT PRIMARY KEY IDENTITY(1,1),
    firstName NVARCHAR(255),
    lastName NVARCHAR(255),
    gender NVARCHAR(50),
    email NVARCHAR(255),
    phoneNumber NVARCHAR(50),
    role NVARCHAR(100),
    status BIT,
    avatarURL NVARCHAR(255),
    password NVARCHAR(255),
    address NVARCHAR(255),
    dateOfBirth DATE
);

-- Bảng blog (Blog)
CREATE TABLE Blog (
    BlogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Title NVARCHAR(255),
    Date DATE,
    Category NVARCHAR(255),
    ImageURL NVARCHAR(255),
    TotalView INT DEFAULT 0,
    Summary TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Nội dung bài blog
CREATE TABLE BlogContent (
    BlogID INT PRIMARY KEY,
    Content TEXT,
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID)
);

-- Bảng khóa học (Course)
CREATE TABLE Course (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255),
    Category NVARCHAR(255),
    Lectures INT,
    ImageURL NVARCHAR(255),
	CourseShortDescription NVARCHAR(255),
    Description TEXT,
	UpdateDate DATETIME DEFAULT GETDATE(),
    TotalEnrollment INT DEFAULT 0
);

-- Slider course Details
CREATE TABLE CourseAdditional (
  CourseID INT NOT NULL,
  ContentURL NVARCHAR(255) NOT NULL,
  IsVideo BIT NOT NULL,
  Caption NVARCHAR(500) NULL,
  Content NVARCHAR(500) NULL,
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Bảng giá theo gói (CoursePackage)
CREATE TABLE CoursePackage (
    PackageID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT,
    PackageName NVARCHAR(255),
    OriginalPrice DECIMAL(10,2),
    SaleRate INT, -- (%) giảm giá
	UseTime INT,
    Description VARCHAR(200),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Review của user
CREATE TABLE CourseReview (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    IsRecommended BIT,
    Comment TEXT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Media của review.
CREATE TABLE CourseReviewMedia (
    MediaID INT IDENTITY(1,1) PRIMARY KEY,
    ReviewID INT NOT NULL,
    MediaURL NVARCHAR(2083),
    IsVideo BIT DEFAULT 0,
	Caption NVARCHAR(255),
    FOREIGN KEY (ReviewID) REFERENCES CourseReview(ReviewID)
);

-- Bảng người dùng và khóa học (UserCourse)
CREATE TABLE UserCourse (
    UserID INT,
    CourseID INT,
	PackageName NVARCHAR(255),
	Price DECIMAL(20,2),
    EnrollDate DATE DEFAULT GETDATE(),
    Progress DECIMAL(5,2),
    Status NVARCHAR(50),
    ValidFrom DATE NULL,
	ValidTo DATE NULL,
    PRIMARY KEY (UserID, CourseID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
);

--Chapter: hiện khi học.
CREATE TABLE Chapter (
  ChapterID INT PRIMARY KEY IDENTITY(1,1),
  CourseID INT NOT NULL,
  Title NVARCHAR(255) NOT NULL,
  ChapterOrder INT NOT NULL,
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Bảng bài học (Lesson) - KHÔNG ĐỔI
CREATE TABLE Lesson (
    LessonID INT PRIMARY KEY IDENTITY(1,1),
    ChapterID INT,
    Title NVARCHAR(255),
    IsFree BIT,
    LessonOrder INT,
	 Status BIT DEFAULT 1,
    FOREIGN KEY (ChapterID) REFERENCES Chapter(ChapterID)
);

-- Nội dung bài học (LessonContent) - KHÔNG ĐỔI
CREATE TABLE LessonContent (
    LessonID INT PRIMARY KEY,
    DocContent TEXT,
    VideoURL NVARCHAR(255),
    FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
);

-- Quản lý tiến trình học của học viên
CREATE TABLE UserLessonActivity (
    ActivityID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    LessonID INT NOT NULL,
	CourseID INT NOT NULL,
    IsCompleted BIT DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
);

--- BẢNG QUẢN LÝ QUIZ VÀ CÂU HỎI ---
CREATE TABLE Quizzes (
    QuizID INT PRIMARY KEY IDENTITY(1,1),
    LessonID INT, -- Có thể NULL nếu là quiz độc lập không gắn với Lesson nào
    CourseID INT, -- Có thể NULL nếu là quiz độc lập không gắn với Course nào
    QuizName NVARCHAR(255) NOT NULL, -- Tên bài quiz (thay thế QuizContent cũ để rõ ràng hơn)
    Subject NVARCHAR(100), -- Chủ đề của quiz (ví dụ: "Toán", "Lịch sử")
    Level NVARCHAR(50), -- Mức độ khó (ví dụ: "Dễ", "Trung bình", "Khó")
    NumQuestions INT, -- Tổng số câu hỏi trong quiz
    DurationMinutes INT, -- Thời lượng làm bài quiz (phút)
    PassRate DECIMAL(5,2), -- Tỷ lệ phần trăm để qua quiz
    QuizType NVARCHAR(50), -- Loại quiz (ví dụ: "Luyện tập", "Kiểm tra", "Thi cuối khóa")
    QuestionOrder INT, -- Thứ tự của quiz trong bài học (nếu có)
    CreatedAt DATETIME DEFAULT GETDATE(), -- Thời điểm tạo quiz
    UpdatedAt DATETIME DEFAULT GETDATE(),
	 Status BIT DEFAULT 1,-- Thời điểm cập nhật cuối cùng
    FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Bảng Questions (tách riêng các câu hỏi của một Quiz)
-- Bảng này chứa các câu hỏi cụ thể trong mỗi bài Quiz.
CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY IDENTITY(1,1),
    QuizID INT NOT NULL,
    QuestionContent TEXT NOT NULL, -- Nội dung câu hỏi
    QuestionType NVARCHAR(50), -- Ví dụ: 'Multiple Choice', 'True/False', 'Short Answer'
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID),
	AnswerKey TEXT NULL,
	Explanation TEXT NULL
);
-- Bảng QuestionOptions (thay thế AnswerQuiz, chứa các lựa chọn/đáp án cho từng câu hỏi)
CREATE TABLE QuestionOptions (
    OptionID INT PRIMARY KEY IDENTITY(1,1),
    QuestionID INT NOT NULL,
    OptionContent TEXT NOT NULL, -- Nội dung của lựa chọn/đáp án
    IsCorrect BIT NOT NULL DEFAULT 0, -- 1 nếu là đáp án đúng, 0 nếu không
    -- Mark DECIMAL(5,2), -- Điểm cho lựa chọn này nếu câu hỏi có nhiều đáp án hoặc điểm khác nhau
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);

-- Bảng QuizAttempts (MỚI) - Để theo dõi lịch sử làm bài của người dùng
-- Bảng này rất quan trọng để xác định liệu một Quiz đã được làm hay chưa (cho yêu cầu "quiz can be editted only when there is not any test taken yet").
CREATE TABLE QuizAttempts (
    AttemptID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    QuizID INT NOT NULL,
    StartTime DATETIME DEFAULT GETDATE(), -- Thời gian bắt đầu làm bài
    EndTime DATETIME, -- Thời gian kết thúc làm bài
    Score DECIMAL(5,2), -- Điểm số đạt được trong lần làm bài này
    IsPassed BIT, -- Liệu người dùng có vượt qua quiz này trong lần thử này
    FOREIGN KEY (UserID) REFERENCES Users(userID),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID)
);

-- Bảng SliderImage - KHÔNG ĐỔI
CREATE TABLE SliderImage (
    SliderID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT,
    SliderTitle NVARCHAR(255) NOT NULL,
    SliderContent TEXT,
    SliderURL NVARCHAR(2083),
	Status BIT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
SET IDENTITY_INSERT SliderImage ON;
-- Thêm bảng QuizAttemptDetails (nếu chưa có)
CREATE TABLE QuizAttemptDetails (
    AttemptDetailID INT PRIMARY KEY IDENTITY(1,1),
    AttemptID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedOptionID INT NULL, -- NULL nếu chưa trả lời hoặc là câu hỏi tự luận
    UserAnswerText TEXT NULL, -- Nếu là câu hỏi tự luận (nếu cần)
    IsMarked BIT DEFAULT 0, -- Để đánh dấu câu hỏi cần xem lại
    FOREIGN KEY (AttemptID) REFERENCES QuizAttempts(AttemptID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
    FOREIGN KEY (SelectedOptionID) REFERENCES QuestionOptions(OptionID)
);
CREATE TABLE PaymentTransaction (
    TransactionId INT IDENTITY PRIMARY KEY,
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
	PackageName NVARCHAR(255),
	UseTime INT,
    OrderCode VARCHAR(100) NOT NULL,         
    Amount DECIMAL(20,2) NOT NULL,
    Vnp_TransactionNo VARCHAR(100),         
    Vnp_ResponseCode VARCHAR(10),
    Vnp_OrderInfo NVARCHAR(255),
    Status VARCHAR(20) CHECK (Status IN ('PENDING', 'SUCCESS', 'FAILED')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    PaidAt DATETIME NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
CREATE TABLE Posts (
    PostID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255),
    BriefInfo NVARCHAR(500),
    Description NVARCHAR(MAX),
	Postinfo NVARCHAR(MAX),
    Category NVARCHAR(100),
    Status NVARCHAR(50),
    IsFeatured BIT DEFAULT 0,
    ThumbnailURL NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE()
);
-- Bảng lưu các video trong bài viết
CREATE TABLE PostVideos (
    VideoID INT PRIMARY KEY IDENTITY(1,1),
    PostID INT FOREIGN KEY REFERENCES Posts(PostID),
    VideoURL NVARCHAR(255),
    Description NVARCHAR(255)
);
-- Bảng lưu các hình ảnh phụ
CREATE TABLE PostImages (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    PostID INT FOREIGN KEY REFERENCES Posts(PostID),
    ImageURL NVARCHAR(255),
    Description NVARCHAR(255)
);

PRINT 'Communication Quiz and Questions inserted.';
PRINT '--- All specified Quizzes with Questions and Options inserted successfully! ---';
INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, QuestionOrder, CreatedAt, UpdatedAt) VALUES
(NULL, NULL, N'Quiz Cơ bản về Lãnh đạo', N'Leadership', N'Dễ', 5, 10, 60.00, N'Luyện tập', NULL, GETDATE(), GETDATE()),
(NULL, NULL, N'Bài kiểm tra Quản lý Thời gian', N'Time Management', N'Trung bình', 10, 20, 70.00, N'Kiểm tra', NULL, GETDATE(), GETDATE()),
(NULL, NULL, N'Thực hành Giải quyết Vấn đề', N'Problem Solving', N'Khó', 8, 15, 65.00, N'Luyện tập', NULL, GETDATE(), GETDATE()),
(NULL, NULL, N'Đánh giá Trí tuệ Cảm xúc', N'Emotional Intelligence', N'Trung bình', 12, 25, 75.00, N'Kiểm tra', NULL, GETDATE(), GETDATE()),
(NULL, NULL, N'Kỹ năng Giao tiếp Hiệu quả', N'Communication', N'Dễ', 7, 10, 60.00, N'Luyện tập', NULL, GETDATE(), GETDATE());
INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, QuestionOrder, Status)
VALUES (3, 1, N'Chiến lược và mục tiêu', N'Leadership', N'Trung bình', 5, 20, 70.00, N'Luyện tập', 1, 1);


INSERT INTO Chapter (CourseID, Title, ChapterOrder) VALUES
(1, 'Understanding Strategic Leadership', 1),
(1, 'Creating Vision and Direction', 2),
(1, 'Making Informed Strategic Decisions', 3),
(2, 'Introduction to Personal Productivity', 1),
(2, 'Using Planning Systems Effectively', 2),
(2, 'Time Blocking and Focus Techniques', 3),
(3, 'Foundations of Self-Awareness', 1),
(3, 'Recognizing Emotional Triggers', 2),
(3, 'Aligning Actions with Values', 3),
(4, 'Building Confidence in Speaking', 1),
(4, 'Crafting Your Message', 2),
(4, 'Delivering with Impact', 3),
(5, 'Defining Leadership Principles', 1),
(5, 'Leading by Example and Integrity', 2),
(5, 'Empathy in Team Leadership', 3),
(6, 'Introduction to Emotional Intelligence', 1),
(6, 'EQ in Leadership and Teams', 2),
(6, 'Practical EQ Strategies at Work', 3),
(7, 'Understanding Problem Types', 1),
(7, 'Problem-Solving Frameworks', 2),
(7, 'Applying Techniques to Real Scenarios', 3),
(8, 'Principles of Critical Thinking', 1),
(8, 'Evaluating Arguments and Evidence', 2),
(8, 'Avoiding Cognitive Biases', 3),
(9, 'Foundations of Communication', 1),
(9, 'Nonverbal and Verbal Techniques', 2),
(9, 'Listening and Adapting Communication', 3),
(10, 'Setting Goals and Priorities', 1),
(10, 'Organizing Your Day with Tools', 2),
(10, 'Building Long-Term Productivity Habits', 3);

INSERT INTO Lesson (ChapterID, Title, IsFree, LessonOrder) VALUES
(1, 'What is Strategic Leadership?', 1, 1),
(1, 'Traits of Successful Strategic Leaders', 0, 2),
(2, 'Creating Vision Statements', 1, 1),
(2, 'Aligning Team Goals with Strategy', 0, 2),
(3, 'Understanding Internal/External Factors', 1, 1),
(3, 'Making Informed Strategic Choices', 0, 2),
(4, 'Introduction to Productivity Concepts', 1, 1),
(4, 'Common Myths About Time Management', 0, 2),
(5, 'Choosing a Productivity System', 1, 1),
(5, 'Setting Weekly Objectives', 0, 2),
(6, 'Time Blocking Basics', 1, 1),
(6, 'Using Calendars Effectively', 0, 2),
(7, 'Defining Self-Awareness', 1, 1),
(7, 'Benefits in Leadership and Life', 0, 2),
(8, 'Identifying Emotional Triggers', 1, 1),
(8, 'Controlling Negative Responses', 0, 2),
(9, 'Defining Personal Core Values', 1, 1),
(9, 'Aligning Goals with Values', 0, 2),
(10, 'Basics of Public Speaking', 1, 1),
(10, 'Controlling Nervousness', 0, 2),
(11, 'Storytelling in Presentations', 1, 1),
(11, 'Using Slides Effectively', 0, 2),
(12, 'Handling Questions with Confidence', 1, 1),
(12, 'Creating Lasting Impact', 0, 2),
(13, 'What Makes a Great Leader?', 1, 1),
(13, 'Modern Leadership Challenges', 0, 2),
(14, 'The Power of Leading by Example', 1, 1),
(14, 'Ethical Leadership Practices', 0, 2),
(15, 'Understanding Empathy in Leadership', 1, 1),
(15, 'Feedback and Coaching Skills', 0, 2),
(16, 'EQ vs. IQ: What Matters?', 1, 1),
(16, 'Core Components of EQ', 0, 2),
(17, 'Emotional Intelligence for Team Success', 1, 1),
(17, 'Resolving Conflict with EQ', 0, 2),
(18, 'Practicing EQ Daily', 1, 1),
(18, 'Self-Regulation Techniques', 0, 2),
(19, 'Types of Business Problems', 1, 1),
(19, 'Understanding Problem Context', 0, 2),
(20, 'How to Use the 5 Whys Method', 1, 1),
(20, 'Applying the Fishbone Diagram', 0, 2),
(21, 'Case Study: Operations Issue', 1, 1),
(21, 'Team-Based Solution Practice', 0, 2),
(22, 'Thinking Clearly and Objectively', 1, 1),
(22, 'Separating Emotion from Logic', 0, 2),
(23, 'Evaluating Sources and Claims', 1, 1),
(23, 'Common Logical Fallacies', 0, 2),
(24, 'Spotting Biases in Thinking', 1, 1),
(24, 'Building Rational Habits', 0, 2),
(25, 'Understanding Message Clarity', 1, 1),
(25, 'Framing Ideas for Impact', 0, 2),
(26, 'Mastering Nonverbal Communication', 1, 1),
(26, 'Adapting to Audiences', 0, 2),
(27, 'Active Listening at Work', 1, 1),
(27, 'Giving and Receiving Feedback', 0, 2),
(28, 'Setting SMART Goals', 1, 1),
(28, 'Clarifying Personal Priorities', 0, 2),
(29, 'Using Tools for Planning', 1, 1),
(29, 'Creating Weekly Action Plans', 0, 2),
(30, 'Daily Reflection and Review Habits', 1, 1),
(30, 'Building Systems for Success', 0, 2);

INSERT INTO Posts (Title, BriefInfo, Description, Category, Status, IsFeatured, ThumbnailURL, Postinfo)
VALUES (
    'Remote Work Communication',
    'Learn how to maintain clear and effective communication with your team members when working remotely.',
    'Remote work has become increasingly common, but it presents unique challenges for team communication. This post explores strategies for maintaining clear and effective communication in remote teams.',
    'Workplace',
    'Published',
    1,
    'media/post/thumbnail1.png',
    'Remote Work: The Future of Work Is Here
Remote work — once a perk — is now a core part of modern professional life. Enabled by technology, it offers flexibility, autonomy, and access to global talent like never before.

Benefits
Flexibility: Work from anywhere, manage your own schedule.

Productivity: Fewer office distractions and commute time.

Cost savings: Reduced overhead for companies; savings on travel and meals for employees.

Work-life balance: More time for family, health, and personal growth.

Challenges
Communication gaps if not managed with the right tools.

Loneliness & isolation without social interaction.

Overworking due to lack of boundaries between home and work.

Best Practices
Use tools like Slack, Zoom, Notion, Trello for collaboration.

Set clear expectations and measurable goals.

Encourage regular check-ins and virtual team building.

Maintain a dedicated workspace to separate personal and professional life.

“Remote work isn’t just a trend — it’s a transformation.”'
);

-- Video chính
INSERT INTO PostVideos (PostID, VideoURL, Description)
VALUES (1, 'media/post/communication.mp4', 'Explain the post');

-- Hình ảnh minh họa chủ đề
INSERT INTO PostImages (PostID, ImageURL, Description)
VALUES (1, 'media/post/topic1.png', 'Topic of the post');

-- Hình ảnh quảng bá khóa học
INSERT INTO PostImages (PostID, ImageURL, Description)
VALUES (1, 'media/post/logo-course.png', 'Logo of the course advertised');

-- Video quảng cáo
INSERT INTO PostVideos (PostID, VideoURL, Description)
VALUES (1, 'media/post/advertise.mp4', 'Advertise course');

PRINT '2. Xóa dữ liệu cũ...';

DELETE FROM QuizAttemptDetails;
PRINT ' - Đã xóa dữ liệu từ QuizAttemptDetails.';
DELETE FROM QuestionOptions;
PRINT ' - Đã xóa dữ liệu từ QuestionOptions.';
DELETE FROM QuizAttempts;
PRINT ' - Đã xóa dữ liệu từ QuizAttempts.';
DELETE FROM Questions;
PRINT ' - Đã xóa dữ liệu từ Questions.';
DELETE FROM Quizzes;
PRINT ' - Đã xóa dữ liệu từ Quizzes.';

-- Reset IDENTITY (auto-increment) để ID bắt đầu từ 1 lại cho các bảng quan trọng
DBCC CHECKIDENT ('QuizAttemptDetails', RESEED, 0);
DBCC CHECKIDENT ('QuestionOptions', RESEED, 0);
DBCC CHECKIDENT ('QuizAttempts', RESEED, 0);
DBCC CHECKIDENT ('Questions', RESEED, 0);
DBCC CHECKIDENT ('Quizzes', RESEED, 0);
PRINT ' - Đã reset IDENTITY cho các bảng liên quan đến Quiz.';

PRINT '3. Chèn dữ liệu Quizzes mới...';

-- Giả định UserID = 1, LessonID = 1001/1002, CourseID = 1/2 đã tồn tại.
-- Nếu chưa, hãy thêm chúng vào bảng Users, Lesson, Course trước đó.

-- Chèn Quiz 1: SQL Basics Quiz
INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, CreatedAt, UpdatedAt) VALUES
(
    1, -- Thay thế bằng LessonID hợp lệ nếu khác
    1,    -- Thay thế bằng CourseID hợp lệ nếu khác
    N'SQL Basics Quiz',
    N'Database',
    N'Beginner',
    0, -- Sẽ cập nhật sau khi thêm câu hỏi
    15,
    70.00,
    N'Practice',
    GETDATE(),
    GETDATE()
);
DECLARE @QuizID_SQL_Basics INT = SCOPE_IDENTITY();
PRINT ' - Đã chèn Quiz: SQL Basics Quiz (ID: ' + CAST(@QuizID_SQL_Basics AS NVARCHAR(10)) + ').';

-- Chèn Quiz 2: Java Fundamentals
INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, CreatedAt, UpdatedAt) VALUES
(
    1001, -- Thay thế bằng LessonID hợp lệ nếu khác
    1,    -- Thay thế bằng CourseID hợp lệ nếu khác
    N'Java Fundamentals',
    N'Programming',
    N'Intermediate',
    0, -- Sẽ cập nhật sau khi thêm câu hỏi
    20,
    75.00,
    N'Assessment',
    GETDATE(),
    GETDATE()
);
DECLARE @QuizID_Java_Fundamentals INT = SCOPE_IDENTITY();
PRINT ' - Đã chèn Quiz: Java Fundamentals (ID: ' + CAST(@QuizID_Java_Fundamentals AS NVARCHAR(10)) + ').';

-- Chèn Quiz 3: Database Normalization
INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, CreatedAt, UpdatedAt) VALUES
(
    1002, -- Thay thế bằng LessonID hợp lệ nếu khác
    2,    -- Thay thế bằng CourseID hợp lệ nếu khác
    N'Database Normalization Quiz',
    N'Database',
    N'Intermediate',
    0, -- Sẽ cập nhật sau khi thêm câu hỏi
    25,
    70.00,
    N'Assessment',
    GETDATE(),
    GETDATE()
);
DECLARE @QuizID_DB_Normalization INT = SCOPE_IDENTITY();
PRINT ' - Đã chèn Quiz: Database Normalization Quiz (ID: ' + CAST(@QuizID_DB_Normalization AS NVARCHAR(10)) + ').';




PRINT '4. Chèn dữ liệu Questions và QuestionOptions...';

-- --- Câu hỏi cho 'SQL Basics Quiz' (QuizID: @QuizID_SQL_Basics) ---

PRINT '   - Bắt đầu chèn câu hỏi cho SQL Basics Quiz...';

-- Q1 (MC): What SQL keyword is used to extract data?
INSERT INTO Questions (QuizID, QuestionContent, QuestionType, Explanation, AnswerKey) VALUES
(1, N'What SQL keyword is used to extract data from a database?', N'Multiple Choice', N'The SELECT statement is used to select data from a database.', NULL);
DECLARE @Q1_SQL_ID INT = SCOPE_IDENTITY();
INSERT INTO QuestionOptions (QuestionID, OptionContent, IsCorrect) VALUES
(1, N'UPDATE', 0), (@Q1_SQL_ID, N'INSERT', 0), (@Q1_SQL_ID, N'SELECT', 1), (@Q1_SQL_ID, N'DELETE', 0);
PRINT '     - Đã thêm Q1 (MC) và options.';

-- Q2 (MC): Which SQL command is used to update data?
INSERT INTO Questions (QuizID, QuestionContent, QuestionType, Explanation, AnswerKey) VALUES
(1, N'Which SQL command is used to update data in a database?', N'Multiple Choice', N'The UPDATE statement is used to modify existing records in a table.', NULL);
DECLARE @Q2_SQL_ID INT = SCOPE_IDENTITY();
INSERT INTO QuestionOptions (QuestionID, OptionContent, IsCorrect) VALUES
(2, N'SELECT', 0), (@Q2_SQL_ID, N'UPDATE', 1), (@Q2_SQL_ID, N'CREATE', 0), (@Q2_SQL_ID, N'DROP', 0);
PRINT '     - Đã thêm Q2 (MC) và options.';

-- Q3 (SA): Explain PRIMARY KEY
INSERT INTO Questions (QuizID, QuestionContent, QuestionType, Explanation, AnswerKey) VALUES
(1, N'Briefly explain the purpose of a PRIMARY KEY in a relational database.', N'Short Answer', N'A primary key uniquely identifies each record in a table, ensuring entity integrity and serving as a basis for establishing relationships with other tables via foreign keys.', N'A primary key uniquely identifies each record in a table, ensuring entity integrity and serving as a basis for establishing relationships with other tables via foreign keys.');
PRINT '     - Đã thêm Q3 (Tự luận).';

-- Q4 (MC): Filter records
INSERT INTO Questions (QuizID, QuestionContent, QuestionType, Explanation, AnswerKey) VALUES
(1, N'Which clause is used to filter records based on a condition in a SELECT statement?', N'Multiple Choice', N'The WHERE clause is used to extract only those records that fulfill a specified condition.', NULL);
DECLARE @Q4_SQL_ID INT = SCOPE_IDENTITY();
INSERT INTO QuestionOptions (QuestionID, OptionContent, IsCorrect) VALUES
(4, N'GROUP BY', 0), (@Q4_SQL_ID, N'ORDER BY', 0), (@Q4_SQL_ID, N'HAVING', 0), (@Q4_SQL_ID, N'WHERE', 1);
PRINT '     - Đã thêm Q4 (MC) và options.';
--Trigger (để cuối)
CREATE TRIGGER UpdateCourseDate
ON Course
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Course
    SET UpdateDate = GETDATE()
    FROM Course c
    INNER JOIN inserted i ON c.CourseID = i.CourseID;
END;