CREATE database SWP391DB;

USE SWP391DB;

-- Bảng người dùng
CREATE TABLE [User] (
  userID INT PRIMARY KEY  IDENTITY(1,1),
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

-- Bảng blog
CREATE TABLE Blog (
    BlogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Title NVARCHAR(255),
    Date DATE,
    Category NVARCHAR(255),
    ImageURL NVARCHAR(255),
    TotalView INT DEFAULT 0,
    Summary TEXT,
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
);

-- Nội dung bài blog
CREATE TABLE BlogContent (
    BlogID INT PRIMARY KEY,
    Content TEXT,
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID)
);

-- Bảng khóa học
CREATE TABLE Course (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255),
    Category NVARCHAR(255),
    Lectures INT,
    ImageURL NVARCHAR(255),
    Description TEXT,
    Price DECIMAL(10,2),
    TotalEnrollment INT DEFAULT 0
);

-- Bảng người dùng và khóa học
CREATE TABLE UserCourse (
    UserID INT,
    CourseID INT,
    IsEnrolled BIT,
    EnrollDate DATE,
    Progress DECIMAL(5,2),
    PRIMARY KEY (UserID, CourseID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Bảng bài học
CREATE TABLE Lesson (
    LessonID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT,
    Title NVARCHAR(255),
    IsFree BIT,
    LessonOrder INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Nội dung bài học
CREATE TABLE LessonContent (
    LessonID INT PRIMARY KEY,
    DocContent TEXT,
    VideoURL NVARCHAR(255),
    FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
);

-- Bảng câu hỏi
CREATE TABLE LessonQuiz (
    QuizID INT PRIMARY KEY IDENTITY(1,1),
    LessonID INT,
    CourseID INT,
    QuizContent TEXT,
    QuestionOrder INT,
    FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Bảng câu trả lời
CREATE TABLE AnswerQuiz (
    AnswerID INT PRIMARY KEY IDENTITY(1,1),
    QuizID INT,
    AnswerContent TEXT,
    IsCorrect BIT,
    Mark DECIMAL(5,2),
    FOREIGN KEY (QuizID) REFERENCES LessonQuiz(QuizID)
);

-- Bảng slider
CREATE TABLE SliderImage (
    SliderID INT PRIMARY KEY IDENTITY(1,1),
	CourseID INT,
    SliderTitle NVARCHAR(255) NOT NULL,
    SliderContent TEXT,
    SliderURL NVARCHAR(2083),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO [User] (firstName, lastName, gender, email, phoneNumber, role, status, avatarURL, password, address, dateOfBirth)
VALUES
('John', 'Doe', 'Male', 'john.doe@example.com', '1234567890', 'Student', 1, 'avatars/john.jpg', 'hashed_password1', '123 Main St, NY', '1995-04-10'),
('Jane', 'Smith', 'Female', 'jane.smith@example.com', '2345678901', 'Instructor', 1, 'avatars/jane.jpg', 'hashed_password2', '456 Park Ave, LA', '1988-09-23'),
('Michael', 'Brown', 'Male', 'michael.brown@example.com', '3456789012', 'Student', 1, 'avatars/michael.jpg', 'hashed_password3', '789 Sunset Blvd, CA', '1992-12-02'),
('Emily', 'Johnson', 'Female', 'emily.j@example.com', '4567890123', 'Student', 1, 'avatars/emily.jpg', 'hashed_password4', '321 Ocean Dr, FL', '1999-06-15'),
('David', 'Wilson', 'Male', 'david.w@example.com', '5678901234', 'Instructor', 1, 'avatars/david.jpg', 'hashed_password5', '111 River Rd, TX', '1985-01-07'),
('Sarah', 'Lee', 'Female', 'sarah.lee@example.com', '6789012345', 'Student', 1, 'avatars/sarah.jpg', 'hashed_password6', '222 Lakeview St, WA', '2000-03-19'),
('Chris', 'Kim', 'Male', 'chris.kim@example.com', '7890123456', 'Student', 1, 'avatars/chris.jpg', 'hashed_password7', '555 Mountain Rd, CO', '1997-07-29'),
('Anna', 'Garcia', 'Female', 'anna.g@example.com', '8901234567', 'Instructor', 1, 'avatars/anna.jpg', 'hashed_password8', '777 Valley Rd, IL', '1990-11-11'),
('Daniel', 'Martinez', 'Male', 'daniel.m@example.com', '9012345678', 'Student', 1, 'avatars/daniel.jpg', 'hashed_password9', '999 Canyon Dr, AZ', '1996-08-05'),
('Laura', 'Nguyen', 'Female', 'laura.nguyen@example.com', '0123456789', 'Student', 1, 'avatars/laura.jpg', 'hashed_password10', '888 Forest Ave, OR', '1994-05-30');

INSERT INTO Blog (UserID, Title, Date, Category, ImageURL, TotalView, Summary)
VALUES
(1, 'Mastering Communication Skills', '2025-05-01', 'Communication', 'images/blog/image1.png', 120, 'Learn how to effectively communicate in both personal and professional settings.'),
(2, 'Time Management Hacks', '2025-05-02', 'Time Management', 'images/blog/image2.png', 98, 'Tips and tricks to manage your time efficiently.'),
(1, 'Building Confidence at Work', '2025-05-03', 'Self Development', 'images/blog/image3.png', 145, 'Boost your confidence with these practical techniques.'),
(3, 'Effective Teamwork Strategies', '2025-05-04', 'Teamwork', 'images/blog/image4.png', 75, 'Collaborate effectively and build strong teams.'),
(2, 'Problem Solving in the Workplace', '2025-05-05', 'Problem Solving', 'images/blog/image5.png', 60, 'Approaches and tools to solve problems efficiently.'),
(4, 'Public Speaking for Beginners', '2025-05-06', 'Communication', 'images/blog/image6.png', 130, 'Overcome fear and deliver impactful speeches.'),
(3, 'How to Handle Criticism Gracefully', '2025-05-07', 'Personal Growth', 'images/blog/image7.png', 90, 'Turn criticism into an opportunity for growth.'),
(1, 'Emotional Intelligence in Leadership', '2025-05-08', 'Leadership', 'images/blog/image8.png', 180, 'Develop emotional intelligence to lead better.'),
(2, 'Negotiation Tactics You Should Know', '2025-05-09', 'Negotiation', 'images/blog/image9.png', 110, 'Win-win strategies for successful negotiations.'),
(4, 'Adaptability in the Modern Workplace', '2025-05-10', 'Adaptability', 'images/blog/image10.png', 70, 'Thrive in a constantly changing work environment.');

INSERT INTO Course (Title, Category, Lectures, ImageURL, Description, Price, TotalEnrollment)
VALUES
('Strategic Leadership', 'Leadership', 10, 'images/courses/image1.png', 'Lead with vision and strategy in dynamic environments.', 32.00, 240),
('Time Management Mastery', 'Time Management', 10, 'images/courses/image2.png', 'Organize your schedule and manage priorities efficiently.', 24.99, 250),
('Mastering Self-Awareness', 'Emotional Intelligence', 7, 'images/courses/image3.png', 'Understand and manage your emotions effectively.', 25.50, 190),
('Public Speaking Essentials', 'Communication', 8, 'images/courses/image4.png', 'Become a confident public speaker with real-world tips.', 19.99, 320),
('Leadership Fundamentals', 'Leadership', 15, 'images/courses/image5.png', 'Gain essential leadership skills to inspire and guide teams.', 34.99, 270),
('Emotional Intelligence at Work', 'Emotional Intelligence', 9, 'images/courses/image6.png', 'Improve emotional awareness and interpersonal skills.', 28.99, 210),
('Problem Solving Techniques', 'Problem Solving', 11, 'images/courses/image7.png', 'Approach and resolve complex issues logically.', 26.99, 180),
('Critical Thinking Skills', 'Problem Solving', 9, 'images/courses/image8.png', 'Learn to analyze situations and make sound decisions.', 23.50, 200),
('Effective Communication Skills', 'Communication', 12, 'images/courses/image9.png', 'Master verbal and non-verbal communication in all contexts.', 29.99, 300),
('Productivity & Planning Bootcamp', 'Time Management', 11, 'images/courses/image10.png', 'Get more done in less time with practical techniques.', 27.99, 230);


INSERT INTO SliderImage (CourseID, SliderTitle, SliderContent, SliderURL)
VALUES
(4, 'Boost Your Confidence in Public Speaking', 'Learn practical tips and techniques to overcome stage fright and speak clearly.', 'images/sliders/image1.png'),
(2, 'Master Time Management Today', 'Prioritize what matters and reclaim your hours with proven time strategies.', 'images/sliders/image2.png'),
(6, 'Enhance Your EQ for Workplace Success', 'Emotional intelligence improves teamwork, communication, and leadership.', 'images/sliders/image3.png'),
(7, 'Become a Pro at Problem Solving', 'Tackle complex problems with confidence using structured problem-solving tools.', 'images/sliders/image4.png');




