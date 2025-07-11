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
	UploadedFilePath NVARCHAR(255),
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