USE SWP391DB;
-- User
INSERT INTO [Users] (firstName, lastName, gender, email, phoneNumber, role, status, avatarURL, password, address, dateOfBirth)
VALUES
('Hoang', 'Son', 'Male', 'sonnhhe189023@fpt.edu.vn', '1234567890', 'User', 1, 'media/users/user_1.png', '123', '123 Main St, NY', '1995-04-10'),
('Jane', 'Smith', 'Female', 'jane.smith@example.com', '2345678901', 'User', 1, 'media/users/user_1.png', 'hashed_password2', '456 Park Ave, LA', '1988-09-23'),
('Michael', 'Brown', 'Male', 'michael.brown@example.com', '3456789012', 'User', 1, 'media/users/user_1.png', 'hashed_password3', '789 Sunset Blvd, CA', '1992-12-02'),
('Emily', 'Johnson', 'Female', 'emily.j@example.com', '4567890123', 'User', 1, 'media/users/user_1.png', 'hashed_password4', '321 Ocean Dr, FL', '1999-06-15'),
('David', 'Wilson', 'Male', 'david.w@example.com', '5678901234', 'User', 1, 'media/users/user_1.png', 'hashed_password5', '111 River Rd, TX', '1985-01-07'),
('Sarah', 'Lee', 'Female', 'sarah.lee@example.com', '6789012345', 'User', 1, 'media/users/user_1.png', 'hashed_password6', '222 Lakeview St, WA', '2000-03-19'),
('Chris', 'Kim', 'Male', 'chris.kim@example.com', '7890123456', 'User', 1, 'media/users/user_1.png', 'hashed_password7', '555 Mountain Rd, CO', '1997-07-29'),
('Anna', 'Garcia', 'Female', 'anna.g@example.com', '8901234567', 'User', 1, 'media/users/user_1.png', 'hashed_password8', '777 Valley Rd, IL', '1990-11-11'),
('Daniel', 'Martinez', 'Male', 'daniel.m@example.com', '9012345678', 'User', 1, 'media/users/user_1.png', 'hashed_password9', '999 Canyon Dr, AZ', '1996-08-05'),
('Laura', 'Nguyen', 'Female', 'laura.nguyen@example.com', '0123456789', 'User', 1, 'media/users/user_1.png', 'hashed_password10', '888 Forest Ave, OR', '1994-05-30');

-- Blog
INSERT INTO Blog (UserID, Title, Date, Category, ImageURL, TotalView, Summary)
VALUES
(1, 'Mastering Communication Skills', '2025-05-01', 'Communication', 'media/blog/image1.png', 120, 'Learn how to effectively communicate in both personal and professional settings.'),
(2, 'Time Management Hacks', '2025-05-02', 'Time Management', 'media/blog/image2.png', 98, 'Tips and tricks to manage your time efficiently.'),
(1, 'Emotional Intelligence in Daily Life', '2025-05-03', 'Emotional Intelligence', 'media/blog/image3.png', 145, 'Manage emotions and improve personal relationships.'),
(4, 'Effective Leadership Habits', '2025-05-04', 'Leadership', 'media/blog/image4.png', 160, 'Daily habits of successful leaders.'),
(3, 'Problem Solving in the Workplace', '2025-05-05', 'Problem Solving', 'media/blog/image5.png', 60, 'Approaches and tools to solve problems efficiently.'),
(4, 'Public Speaking for Beginners', '2025-05-06', 'Communication', 'media/blog/image6.png', 130, 'Overcome fear and deliver impactful speeches.'),
(2, 'Time Blocking Method Explained', '2025-05-07', 'Time Management', 'media/blog/image7.png', 90, 'Use time blocking to stay focused and productive.'),
(6, 'Empathy in Leadership', '2025-05-08', 'Leadership', 'media/blog/image8.png', 180, 'How empathetic leadership drives team success.'),
(8, 'Boost Your Emotional Intelligence', '2025-05-09', 'Emotional Intelligence', 'media/blog/image9.png', 110, 'Recognize and manage emotional triggers effectively.'),
(9, 'Critical Thinking Techniques', '2025-05-10', 'Problem Solving', 'media/blog/image10.png', 70, 'Sharpen your analytical skills for better decisions.');

-- Blog content
INSERT INTO BlogContent (BlogID, Content) VALUES
(1, '
<p>Effective communication is one of the most essential skills to succeed in both personal and professional life. It involves not just speaking clearly but also listening attentively, understanding non-verbal cues, and adapting your message to the audience.</p>

<h3>Why Communication Matters</h3>
<p>Communication is the foundation of all relationships and teamwork. When messages are conveyed clearly, misunderstandings reduce, productivity increases, and conflicts are minimized. Whether you\re giving a presentation, negotiating, or just having a casual conversation, your ability to communicate well directly impacts your success.</p>

<h3>Core Communication Skills</h3>
<ul>
  <li><strong>Active Listening:</strong> Pay full attention to the speaker, avoid interrupting, and provide feedback to confirm understanding.</li>
  <li><strong>Clear Articulation:</strong> Use simple language and avoid jargon unless necessary. Speak at a pace that is easy to follow.</li>
  <li><strong>Non-Verbal Communication:</strong> Body language, facial expressions, eye contact, and gestures all contribute to your message.</li>
  <li><strong>Empathy:</strong> Understand the emotions behind words and respond appropriately.</li>
</ul>

<h3>Tips to Improve Your Communication</h3>
<ol>
  <li><strong>Practice Active Listening:</strong> Instead of planning what to say next, focus fully on the speaker.</li>
  <li><strong>Be Clear and Concise:</strong> Avoid unnecessary details. Structure your message with a beginning, middle, and end.</li>
  <li><strong>Ask Questions:</strong> Clarify doubts to avoid assumptions.</li>
  <li><strong>Observe Reactions:</strong> Adjust your message if the listener looks confused or disengaged.</li>
  <li><strong>Give and Receive Feedback:</strong> Use constructive criticism to improve your skills.</li>
</ol>

<h3>Common Barriers to Communication</h3>
<p>Noise, cultural differences, emotional biases, and misunderstandings can hinder effective communication. Being aware of these barriers helps you navigate and overcome them.</p>

<h3>Conclusion</h3>
<p>Mastering communication skills takes time and conscious effort, but the benefits are immense � from stronger relationships to better career opportunities. Start with small daily practices, and you\ll see gradual improvement that transforms your interactions.</p>
'),

(2, '
<p>Time is a finite resource, and managing it effectively is crucial to achieving both professional and personal goals. Mastering time management reduces stress, increases productivity, and allows you to focus on what truly matters.</p>

<h3>Understanding Time Management</h3>
<p>Time management means planning and exercising conscious control over the time spent on specific activities to increase effectiveness, efficiency, and productivity.</p>

<h3>Key Principles of Time Management</h3>
<ul>
  <li><strong>Prioritization:</strong> Focus on tasks that provide the highest value and impact.</li>
  <li><strong>Planning:</strong> Organize your day and week ahead to avoid last-minute rushes.</li>
  <li><strong>Avoiding Procrastination:</strong> Tackle difficult tasks first when your energy is highest.</li>
  <li><strong>Delegation:</strong> Assign tasks that others can do, freeing you to focus on critical responsibilities.</li>
</ul>

<h3>Effective Time Management Hacks</h3>
<ol>
  <li><strong>Use the Eisenhower Matrix:</strong> Categorize tasks by urgency and importance. Focus on �important and urgent� first, then �important but not urgent.�</li>
  <li><strong>Time Blocking:</strong> Schedule dedicated time slots for specific activities to improve focus and reduce multitasking.</li>
  <li><strong>Set SMART Goals:</strong> Goals that are Specific, Measurable, Achievable, Relevant, and Time-bound give clear direction.</li>
  <li><strong>Batch Similar Tasks:</strong> Group similar tasks together (like emails or calls) to maintain workflow.</li>
  <li><strong>Use Technology Wisely:</strong> Tools like Google Calendar, Trello, and Pomodoro timers can help organize your time efficiently.</li>
  <li><strong>Take Regular Breaks:</strong> Short breaks during work boost focus and prevent burnout.</li>
</ol>

<h3>Dealing with Distractions</h3>
<p>Social media, unnecessary meetings, and noisy environments can steal valuable time. To combat this:</p>
<ul>
  <li>Turn off non-essential notifications.</li>
  <li>Set �do not disturb� periods.</li>
  <li>Create a dedicated workspace.</li>
</ul>

<h3>Benefits of Mastering Time Management</h3>
<p>Good time management leads to more free time, less stress, higher work quality, and a better work-life balance. It also builds discipline and enhances your reputation as a reliable individual.</p>

<h3>Conclusion</h3>
<p>Incorporate these time management hacks gradually into your routine. Remember, the goal is not to be busy but to be productive and fulfilled.</p>
'),

(3, '
<p>Emotional intelligence (EI) is the ability to recognize, understand, and manage our own emotions as well as recognize, understand, and influence the emotions of others. It plays a critical role in our social interactions, mental well-being, and overall success.</p>

<h3>What is Emotional Intelligence?</h3>
<p>EI consists of several key components:</p>
<ul>
  <li><strong>Self-awareness:</strong> Knowing your own emotions and how they affect your thoughts and behavior.</li>
  <li><strong>Self-regulation:</strong> Managing your emotions healthily and constructively.</li>
  <li><strong>Motivation:</strong> Harnessing emotions to pursue goals with energy and persistence.</li>
  <li><strong>Empathy:</strong> Understanding the emotions of others.</li>
  <li><strong>Social Skills:</strong> Managing relationships and building networks.</li>
</ul>

<h3>Why is Emotional Intelligence Important?</h3>
<p>EI influences how well you handle stress, communicate with others, overcome challenges, and resolve conflicts. High EI is linked to stronger relationships, success at work, and better mental health.</p>

<h3>Developing Self-Awareness</h3>
<p>Start by paying attention to your emotions throughout the day. Journaling or mindfulness meditation can help you notice emotional patterns and triggers.</p>

<h3>Improving Self-Regulation</h3>
<ul>
  <li>Practice pausing before reacting emotionally.</li>
  <li>Use deep breathing or counting to calm yourself.</li>
  <li>Shift perspective to reduce negative feelings.</li>
</ul>

<h3>Building Empathy</h3>
<p>Put yourself in others\shoes by actively listening without judgment. Validate others� feelings to build trust and rapport.</p>

<h3>Enhancing Social Skills</h3>
<ul>
  <li>Work on clear and respectful communication.</li>
  <li>Collaborate effectively in team settings.</li>
  <li>Manage conflicts constructively.</li>
</ul>

<h3>Practical Tips to Boost EI</h3>
<ol>
  <li>Seek feedback from trusted friends or colleagues on how you handle emotions.</li>
  <li>Practice mindfulness daily to improve emotional awareness.</li>
  <li>Engage in activities that challenge your emotional responses, such as volunteering or public speaking.</li>
</ol>

<h3>Conclusion</h3>
<p>Emotional intelligence is not a fixed trait � it can be developed with conscious effort. Enhancing your EI can transform your personal relationships and professional interactions, leading to a more fulfilling and successful life.</p>
'),
(4, '
<p>Effective leadership is a combination of habits, mindset, and skills that inspire others to achieve common goals. Great leaders don�t just give orders; they motivate, empower, and set examples.</p>

<h3>Understanding Leadership</h3>
<p>Leadership goes beyond managing tasks�it\s about influencing people positively. Whether you lead a small team or a large organization, your daily habits shape the culture and productivity of your group.</p>

<h3>Daily Habits of Successful Leaders</h3>
<ul>
  <li><strong>Clear Communication:</strong> Consistently share vision and expectations with clarity.</li>
  <li><strong>Active Listening:</strong> Pay attention to team members� ideas and concerns.</li>
  <li><strong>Lead by Example:</strong> Model the behaviors and ethics you expect from others.</li>
  <li><strong>Continuous Learning:</strong> Stay curious and seek new knowledge regularly.</li>
  <li><strong>Empathy and Support:</strong> Understand challenges faced by team members and provide help.</li>
  <li><strong>Time Management:</strong> Prioritize high-impact tasks and delegate effectively.</li>
</ul>

<h3>Building Trust and Accountability</h3>
<p>Leaders build trust by being honest and transparent. They hold themselves and others accountable, celebrate successes, and address failures constructively.</p>

<h3>Handling Challenges</h3>
<p>Effective leaders remain calm under pressure, make informed decisions, and adapt quickly to change. They use setbacks as opportunities to learn and grow.</p>

<h3>Tips to Develop Leadership Habits</h3>
<ol>
  <li>Set personal daily goals aligned with your leadership vision.</li>
  <li>Seek feedback regularly from peers and mentors.</li>
  <li>Read books and attend workshops on leadership skills.</li>
  <li>Practice mindfulness to improve emotional intelligence.</li>
  <li>Celebrate team achievements to foster motivation.</li>
</ol>

<h3>Conclusion</h3>
<p>Leadership is a journey, not a destination. Developing effective leadership habits requires intention and perseverance but leads to impactful and rewarding results.</p>
'),

(5, '
<p>Problem solving is a critical skill in the workplace that enables individuals and teams to overcome obstacles and seize opportunities. Efficient problem solvers identify root causes and create actionable solutions.</p>

<h3>Importance of Problem Solving</h3>
<p>Every organization faces challenges�from technical issues to interpersonal conflicts. Being able to address problems promptly minimizes disruption and drives success.</p>

<h3>Steps in the Problem Solving Process</h3>
<ol>
  <li><strong>Identify the Problem:</strong> Clearly define what the issue is.</li>
  <li><strong>Analyze the Problem:</strong> Gather information and determine root causes.</li>
  <li><strong>Generate Solutions:</strong> Brainstorm multiple options without judgment.</li>
  <li><strong>Evaluate and Select:</strong> Weigh pros and cons and pick the best solution.</li>
  <li><strong>Implement the Solution:</strong> Develop an action plan and execute it.</li>
  <li><strong>Review Results:</strong> Assess effectiveness and adjust if needed.</li>
</ol>

<h3>Tools and Techniques</h3>
<ul>
  <li><strong>Root Cause Analysis (5 Whys):</strong> Ask �why� repeatedly to drill down to the cause.</li>
  <li><strong>SWOT Analysis:</strong> Evaluate strengths, weaknesses, opportunities, and threats.</li>
  <li><strong>Mind Mapping:</strong> Visualize problems and possible solutions.</li>
  <li><strong>Decision Matrix:</strong> Score and compare options based on criteria.</li>
</ul>

<h3>Common Challenges</h3>
<p>Problem solvers often face biases, lack of information, or resistance to change. Being aware of these helps to maintain objectivity.</p>

<h3>Improving Your Problem Solving Skills</h3>
<ol>
  <li>Practice critical thinking by questioning assumptions.</li>
  <li>Work collaboratively to gain diverse perspectives.</li>
  <li>Stay calm and patient, especially in complex issues.</li>
  <li>Learn from past mistakes and successes.</li>
</ol>

<h3>Conclusion</h3>
<p>Problem solving is a dynamic skill that combines analysis, creativity, and communication. Enhancing this skill empowers you to tackle challenges confidently and contribute meaningfully to your workplace.</p>
'),

(6, '
<p>Public speaking is a powerful skill that can boost your confidence and open doors to professional growth. Many people fear speaking in public, but with practice, anyone can become an effective speaker.</p>

<h3>Why Public Speaking Matters</h3>
<p>Whether presenting ideas at work, speaking at events, or leading meetings, good public speaking helps you engage your audience and communicate your message clearly.</p>

<h3>Overcoming Fear of Public Speaking</h3>
<ul>
  <li><strong>Preparation:</strong> Know your material thoroughly to boost confidence.</li>
  <li><strong>Practice:</strong> Rehearse multiple times, including in front of friends or mirrors.</li>
  <li><strong>Visualization:</strong> Picture yourself succeeding to reduce anxiety.</li>
  <li><strong>Breathing Techniques:</strong> Use deep breaths to calm nerves.</li>
  <li><strong>Focus on the Message:</strong> Shift attention from yourself to the value you\re delivering.</li>
</ul>

<h3>Key Elements of Effective Public Speaking</h3>
<ul>
  <li><strong>Clarity:</strong> Speak clearly and at a moderate pace.</li>
  <li><strong>Engagement:</strong> Use eye contact, gestures, and vary tone to keep audience interested.</li>
  <li><strong>Structure:</strong> Organize your talk with a clear introduction, body, and conclusion.</li>
  <li><strong>Visual Aids:</strong> Use slides or props to support your points, not overwhelm them.</li>
  <li><strong>Storytelling:</strong> Incorporate stories or examples to make your message relatable.</li>
</ul>

<h3>Tips to Improve Public Speaking Skills</h3>
<ol>
  <li>Join groups like Toastmasters to practice regularly.</li>
  <li>Record yourself and review your performance.</li>
  <li>Seek constructive feedback and apply it.</li>
  <li>Learn from great speakers by watching TED talks or speeches.</li>
  <li>Focus on continuous improvement rather than perfection.</li>
</ol>

<h3>Conclusion</h3>
<p>With dedication and practice, public speaking can transform from a fear into a strength. It enables you to influence, inspire, and connect with others effectively.</p>
'),
(7, '
<p>The Time Blocking Method is a powerful time management technique that helps you organize your day into focused blocks dedicated to specific tasks. This method can increase productivity and reduce distractions.</p>

<h3>What is Time Blocking?</h3>
<p>Time blocking involves dividing your schedule into blocks of time, each allocated to a particular activity. Instead of multitasking, you concentrate fully on one task during its designated block.</p>

<h3>Benefits of Time Blocking</h3>
<ul>
  <li><strong>Improved Focus:</strong> Concentrate on one task at a time without interruptions.</li>
  <li><strong>Better Time Awareness:</strong> Understand how much time tasks truly take.</li>
  <li><strong>Reduced Procrastination:</strong> Having scheduled time encourages action.</li>
  <li><strong>Work-Life Balance:</strong> Plan breaks and personal time deliberately.</li>
</ul>

<h3>How to Implement Time Blocking</h3>
<ol>
  <li>List all tasks and prioritize them.</li>
  <li>Estimate time required for each task.</li>
  <li>Schedule blocks for each task on your calendar.</li>
  <li>Include buffer times between blocks for flexibility.</li>
  <li>Stick to the schedule and avoid distractions.</li>
</ol>

<h3>Tools to Help Time Blocking</h3>
<p>Use digital calendars like Google Calendar or apps designed for time blocking to plan and remind you of your schedule.</p>

<h3>Tips for Success</h3>
<ul>
  <li>Start with blocking just your workday, then expand to personal time.</li>
  <li>Review and adjust blocks daily based on priorities.</li>
  <li>Communicate your schedule with colleagues to minimize interruptions.</li>
</ul>

<h3>Conclusion</h3>
<p>The Time Blocking Method can transform your productivity by helping you focus and manage time deliberately. With consistent practice, it becomes a habit that supports your goals.</p>
'),

(8, '
<p>Empathy in leadership is the ability to understand and share the feelings of others, creating a supportive and trusting environment. Empathetic leaders build stronger teams and foster collaboration.</p>

<h3>Why Empathy Matters in Leadership</h3>
<p>Empathy helps leaders connect with their team members on a human level, improving communication, morale, and engagement.</p>

<h3>Key Characteristics of Empathetic Leaders</h3>
<ul>
  <li><strong>Active Listening:</strong> Truly hear and understand concerns.</li>
  <li><strong>Open-mindedness:</strong> Accept different perspectives without judgment.</li>
  <li><strong>Emotional Awareness:</strong> Recognize emotions in self and others.</li>
  <li><strong>Supportiveness:</strong> Offer help and encouragement when needed.</li>
  <li><strong>Authenticity:</strong> Be genuine in your interactions.</li>
</ul>

<h3>Benefits of Empathetic Leadership</h3>
<ul>
  <li>Improved team trust and loyalty.</li>
  <li>Higher employee satisfaction and retention.</li>
  <li>Better conflict resolution.</li>
  <li>Enhanced creativity and innovation.</li>
</ul>

<h3>How to Develop Empathy as a Leader</h3>
<ol>
  <li>Practice active listening in daily conversations.</li>
  <li>Seek feedback to understand how others perceive you.</li>
  <li>Put yourself in others� shoes before making decisions.</li>
  <li>Show vulnerability to create open dialogue.</li>
  <li>Engage in team-building activities that foster connection.</li>
</ol>

<h3>Conclusion</h3>
<p>Empathy is a vital leadership skill that cultivates a positive workplace culture. Leaders who lead with empathy inspire commitment and drive success.</p>
'),

(9, '
<p>Boosting your emotional intelligence (EI) is crucial for managing relationships and responding effectively to challenges. EI involves recognizing, understanding, and managing your own emotions as well as those of others.</p>

<h3>Components of Emotional Intelligence</h3>
<ul>
  <li><strong>Self-awareness:</strong> Recognizing your own emotions.</li>
  <li><strong>Self-regulation:</strong> Managing emotions constructively.</li>
  <li><strong>Motivation:</strong> Using emotions to pursue goals.</li>
  <li><strong>Empathy:</strong> Understanding others\ feelings.</li>
  <li><strong>Social Skills:</strong> Building and maintaining relationships.</li>
</ul>

<h3>Benefits of High Emotional Intelligence</h3>
<ul>
  <li>Improved communication and teamwork.</li>
  <li>Better stress management.</li>
  <li>Enhanced leadership abilities.</li>
  <li>Greater resilience and adaptability.</li>
</ul>

<h3>Strategies to Boost Your Emotional Intelligence</h3>
<ol>
  <li>Practice mindfulness to become more self-aware.</li>
  <li>Reflect on emotional responses and triggers.</li>
  <li>Develop active listening skills.</li>
  <li>Engage in empathy exercises.</li>
  <li>Seek feedback and be open to change.</li>
</ol>

<h3>Emotional Intelligence in the Workplace</h3>
<p>Employees with high EI contribute to a positive culture and effective collaboration, which leads to higher productivity and job satisfaction.</p>

<h3>Conclusion</h3>
<p>Boosting emotional intelligence is an ongoing process that enhances both personal and professional life. It empowers you to navigate complex social environments with confidence.</p>
'),

(10, '
<p>Critical thinking is the ability to analyze facts to form a judgment. In the workplace, it is essential for making informed decisions and solving complex problems efficiently.</p>

<h3>What is Critical Thinking?</h3>
<p>Critical thinkers question assumptions, evaluate evidence, and consider alternative perspectives before reaching conclusions.</p>

<h3>Importance of Critical Thinking</h3>
<ul>
  <li>Improves decision-making quality.</li>
  <li>Encourages open-mindedness and creativity.</li>
  <li>Helps identify and avoid logical fallacies.</li>
  <li>Enhances problem-solving capabilities.</li>
</ul>

<h3>Steps to Develop Critical Thinking</h3>
<ol>
  <li>Ask clarifying questions.</li>
  <li>Gather and assess relevant information.</li>
  <li>Consider different viewpoints.</li>
  <li>Draw conclusions based on evidence.</li>
  <li>Reflect on your reasoning process.</li>
</ol>

<h3>Techniques to Practice Critical Thinking</h3>
<ul>
  <li>Engage in debates or discussions.</li>
  <li>Analyze case studies and scenarios.</li>
  <li>Practice problem-solving exercises.</li>
  <li>Keep a journal to reflect on decisions.</li>
</ul>

<h3>Conclusion</h3>
<p>Critical thinking is a vital skill that strengthens your ability to make sound judgments and innovate. Regular practice sharpens your mind and empowers your career.</p>');

--Course
INSERT INTO Course (Title, Category, Lectures, ImageURL, CourseShortDescription, Description, UpdateDate, TotalEnrollment) VALUES
('Strategic Leadership', 'Leadership', 10, 'media/courses/image1.png',
'Lead with vision and strategy in dynamic environments.',
'
<p>Strategic leadership is about steering an organization toward long-term success by aligning people, vision, and strategy. Unlike traditional leadership, which may focus on daily operations, strategic leadership emphasizes foresight, adaptability, and innovation.</p>
<h3>What Makes a Leader Strategic?</h3>
<p>A strategic leader sees the big picture and anticipates changes in the business environment. They are visionaries who align their team with future goals and prepare the organization to stay competitive. This involves assessing strengths and weaknesses, analyzing trends, and making proactive decisions.</p>
<h3>Key Areas of Strategic Leadership</h3>
<ul>
  <li><strong>Vision Development:</strong> Creating a compelling and actionable vision that inspires others.</li>
  <li><strong>Change Management:</strong> Guiding the organization through change with confidence and clarity.</li>
  <li><strong>Decision Making:</strong> Using data, experience, and instinct to make sound strategic choices.</li>
  <li><strong>Empowerment:</strong> Encouraging team members to contribute to strategic thinking and execution.</li>
</ul>
<h3>Developing Your Strategic Thinking</h3>
<ol>
  <li><strong>Study Market Trends:</strong> Stay updated with industry developments to anticipate changes.</li>
  <li><strong>Set Long-Term Goals:</strong> Think beyond quarterly targets and envision where your team should be in 3�5 years.</li>
  <li><strong>Engage Stakeholders:</strong> Collaborate with team members, investors, and customers to create shared goals.</li>
  <li><strong>Reflect & Adapt:</strong> Regularly evaluate outcomes and adjust strategies as needed.</li>
</ol>
<h3>Conclusion</h3>
<p>Strategic leadership is a powerful skill that combines vision, influence, and execution. By learning how to lead strategically, you position yourself and your organization for sustainable growth and success.</p>
', '2025-06-1', 240),
('Time Management Mastery', 'Time Management', 10, 'media/courses/image2.png',
'Organize your schedule and manage priorities efficiently.',
'
<p>Time management is more than just filling out a planner�it''s about intentionally allocating your time to achieve meaningful goals while maintaining balance. In a world of distractions and busy schedules, mastering your time is the key to reducing stress and increasing productivity.</p>
<h3>Why Time Management Matters</h3>
<p>When you manage your time effectively, you�re in control of your life. You can prioritize tasks, meet deadlines, and have space left for personal growth and relaxation. Without good time habits, even the most talented individuals can feel overwhelmed and underperform.</p>
<h3>Core Principles of Time Management</h3>
<ul>
  <li><strong>Goal Setting:</strong> Know what you want to achieve and set SMART goals to get there.</li>
  <li><strong>Prioritization:</strong> Use tools like the Eisenhower Matrix to distinguish urgent vs. important tasks.</li>
  <li><strong>Planning:</strong> Block out time for deep work, routine tasks, and breaks.</li>
  <li><strong>Delegation:</strong> Know when to delegate and trust others with tasks.</li>
</ul>
<h3>Effective Techniques</h3>
<ol>
  <li><strong>Pomodoro Technique:</strong> Work in focused 25-minute intervals with short breaks to maintain energy.</li>
  <li><strong>Time Blocking:</strong> Allocate chunks of time for specific activities in your calendar.</li>
  <li><strong>To-Do Lists:</strong> Keep daily, weekly, and monthly lists for better organization.</li>
  <li><strong>Review & Reflect:</strong> End each day or week by reviewing what worked and what didn�t.</li>
</ol>
<h3>Conclusion</h3>
<p>Mastering time management is a lifelong journey. With practice and discipline, you can reduce stress, boost productivity, and create more space for the things that truly matter.</p>
', '2025-06-2', 250),
('Mastering Self-Awareness', 'Emotional Intelligence', 7, 'media/courses/image3.png',
'Understand and manage your emotions effectively.',
'
<p>Self-awareness is the foundation of emotional intelligence, strong leadership, and meaningful relationships. It�s about recognizing your thoughts, emotions, and behaviors�and understanding how they affect yourself and others.</p>
<h3>Why Self-Awareness Matters</h3>
<p>When youre self-aware, youre better equipped to handle feedback, manage stress, and improve decision-making. You understand your strengths and weaknesses and can take proactive steps to grow. In the workplace, self-aware individuals are more empathetic, resilient, and influential.</p>
<h3>Dimensions of Self-Awareness</h3>
<ul>
  <li><strong>Internal Self-Awareness:</strong> Understanding your values, passions, and impact on others.</li>
  <li><strong>External Self-Awareness:</strong> Knowing how others perceive you, and using that insight to adapt.</li>
</ul>
<h3>Practices to Build Self-Awareness</h3>
<ol>
  <li><strong>Journaling:</strong> Reflect daily on your thoughts, emotions, and reactions.</li>
  <li><strong>Mindfulness:</strong> Practice being present to observe your thoughts without judgment.</li>
  <li><strong>Seek Feedback:</strong> Ask trusted peers or mentors for honest input.</li>
  <li><strong>Personality Assessments:</strong> Use tools like MBTI or DISC to gain insights.</li>
</ol>
<h3>Benefits of Being Self-Aware</h3>
<p>Greater self-awareness leads to better emotional regulation, stronger communication, and more effective leadership. It also fosters humility and openness to learning�essential traits in any successful career.</p>
<h3>Conclusion</h3>
<p>Self-awareness is not a destination but a continuous journey. The more you learn about yourself, the more empowered you become to make conscious choices that align with your values and purpose.</p>
', '2025-06-3', 190),
('Public Speaking Essentials', 'Communication', 8, 'media/courses/image4.png',
'Become a confident public speaker with real-world tips.',
'
<p>Public speaking is a skill that can open doors to new opportunities, whether youre delivering a presentation, pitching an idea, or leading a team. It�s not just about talking�it�s about connecting, persuading, and inspiring your audience.</p>
<h3>Why Public Speaking Skills Matter</h3>
<p>Effective public speakers are often seen as more confident, credible, and influential. When you can articulate your ideas clearly and passionately, you gain trust, build authority, and make a lasting impression.</p>
<h3>Fundamentals of Public Speaking</h3>
<ul>
  <li><strong>Know Your Audience:</strong> Understand their needs, background, and expectations.</li>
  <li><strong>Structure Your Message:</strong> Use a clear introduction, body, and conclusion to guide your audience.</li>
  <li><strong>Practice Delivery:</strong> Rehearse your tone, pace, body language, and eye contact.</li>
  <li><strong>Manage Anxiety:</strong> Learn breathing techniques and mental strategies to stay calm.</li>
</ul>
<h3>Tips to Improve Public Speaking</h3>
<ol>
  <li><strong>Tell Stories:</strong> Use personal experiences or anecdotes to make your message relatable.</li>
  <li><strong>Engage the Audience:</strong> Ask questions, use visuals, or involve them in activities.</li>
  <li><strong>Get Feedback:</strong> Record yourself or ask others for constructive criticism.</li>
  <li><strong>Start Small:</strong> Practice in low-stakes settings like meetings or group discussions.</li>
</ol>
<h3>Conclusion</h3>
<p>With consistent effort, anyone can become an effective speaker. Public speaking is a journey, and every talk is an opportunity to improve your voice, your message, and your confidence.</p>
', '2025-06-4', 320),
('Leadership Fundamentals', 'Leadership', 15, 'media/courses/image5.png',
'Gain essential leadership skills to inspire and guide teams.',
'
<p>Leadership is more than a job title�it�s about guiding others toward a shared vision and helping them thrive along the way. Whether you''re new to a leadership role or looking to refine your style, understanding the fundamentals is crucial.</p>
<h3>What Makes a Good Leader?</h3>
<p>Great leaders inspire trust, communicate clearly, and make decisions that benefit the whole team. They balance results with relationships and lead by example, not just direction.</p>
<h3>Core Leadership Skills</h3>
<ul>
  <li><strong>Vision:</strong> Set clear goals and articulate a compelling direction.</li>
  <li><strong>Communication:</strong> Listen actively and share information transparently.</li>
  <li><strong>Empowerment:</strong> Encourage autonomy, provide support, and develop others.</li>
  <li><strong>Adaptability:</strong> Lead through change and handle uncertainty with resilience.</li>
</ul>
<h3>Practical Steps to Improve Leadership</h3>
<ol>
  <li><strong>Reflect on Your Style:</strong> Understand your strengths, weaknesses, and leadership tendencies.</li>
  <li><strong>Build Relationships:</strong> Foster trust and rapport with your team members.</li>
  <li><strong>Lead with Integrity:</strong> Be honest, fair, and consistent in your actions.</li>
  <li><strong>Embrace Feedback:</strong> Use it to grow and improve both personally and professionally.</li>
</ol>
<h3>Conclusion</h3>
<p>Leadership is a skill that grows with experience, awareness, and feedback. By focusing on core principles and staying true to your values, you can lead with impact and authenticity.</p>
', '2025-06-5', 270),
('Emotional Intelligence at Work', 'Emotional Intelligence', 9, 'media/courses/image6.png',
'Improve emotional awareness and interpersonal skills.',
'
<p>Emotional intelligence (EQ) is the ability to recognize, understand, and manage your emotions�and to do the same with others. At work, EQ helps you navigate relationships, lead with empathy, and handle stress effectively.</p>
<h3>Why EQ is Crucial in the Workplace</h3>
<p>High EQ enhances teamwork, improves communication, and increases job satisfaction. Employees with strong emotional intelligence are better problem solvers, conflict managers, and collaborators.</p>
<h3>The Five Elements of EQ</h3>
<ul>
  <li><strong>Self-Awareness:</strong> Recognizing your emotions and their impact on your behavior.</li>
  <li><strong>Self-Regulation:</strong> Managing your impulses, moods, and reactions.</li>
  <li><strong>Motivation:</strong> Staying driven and focused on goals despite setbacks.</li>
  <li><strong>Empathy:</strong> Understanding others� emotions and responding with compassion.</li>
  <li><strong>Social Skills:</strong> Building relationships, resolving conflicts, and influencing positively.</li>
</ul>
<h3>Ways to Build EQ at Work</h3>
<ol>
  <li><strong>Practice Mindfulness:</strong> Pause and observe your emotional state before reacting.</li>
  <li><strong>Use "I" Statements:</strong> Express how you feel without blaming others.</li>
  <li><strong>Learn to Listen:</strong> Give your full attention and reflect back what you hear.</li>
  <li><strong>Stay Curious:</strong> Ask questions and show genuine interest in others� perspectives.</li>
</ol>
<h3>Conclusion</h3>
<p>Emotional intelligence isn�t fixed�it can be developed with awareness and practice. By honing your EQ, you can improve your work relationships, boost performance, and create a more positive and productive environment.</p>
', '2025-06-6', 210),
('Problem Solving Techniques', 'Problem Solving', 11, 'media/courses/image7.png',
'Approach and resolve complex issues logically.',
'
<p>Problem solving is a core skill in today�s dynamic world. Whether you�re in business, education, or daily life, the ability to approach challenges methodically and creatively makes all the difference.</p>
<h3>Why Problem Solving Matters</h3>
<p>Strong problem-solving skills help you make better decisions, reduce stress, and create innovative solutions. It allows teams to move forward efficiently and ensures fewer mistakes in execution.</p>
<h3>Key Steps in Problem Solving</h3>
<ul>
  <li><strong>Identify the Problem:</strong> Clearly define what the issue is and why it matters.</li>
  <li><strong>Analyze the Root Cause:</strong> Use tools like the "5 Whys" or cause-effect diagrams.</li>
  <li><strong>Generate Solutions:</strong> Brainstorm multiple ideas before choosing one.</li>
  <li><strong>Test and Implement:</strong> Pilot your solution and gather feedback for refinement.</li>
</ul>
<h3>Strategies to Improve</h3>
<ol>
  <li><strong>Stay Objective:</strong> Avoid jumping to conclusions or letting emotions cloud judgment.</li>
  <li><strong>Break Down Problems:</strong> Divide complex challenges into smaller, manageable parts.</li>
  <li><strong>Collaborate:</strong> Leverage diverse viewpoints to find better solutions.</li>
  <li><strong>Review Outcomes:</strong> Learn from successes and failures to improve future decisions.</li>
</ol>
<h3>Conclusion</h3>
<p>Problem solving is not about always having the right answer, but about having the right mindset. With practice and structure, you can turn challenges into opportunities for growth and innovation.</p>
', '2025-06-7', 180),
('Critical Thinking Skills', 'Problem Solving', 9, 'media/courses/image8.png',
'Learn to analyze situations and make sound decisions.',
'
<p>Critical thinking is the ability to objectively analyze information and make reasoned judgments. It�s essential for navigating complex information and avoiding cognitive biases.</p>
<h3>What is Critical Thinking?</h3>
<p>It involves evaluating evidence, questioning assumptions, and identifying logical connections. Critical thinkers don�t accept information at face value�they ask �why,� �how,� and �what else?�</p>
<h3>Core Components</h3>
<ul>
  <li><strong>Analysis:</strong> Break down information and assess its validity.</li>
  <li><strong>Evaluation:</strong> Weigh evidence and arguments fairly.</li>
  <li><strong>Inference:</strong> Draw logical conclusions from available data.</li>
  <li><strong>Reflection:</strong> Consider your own beliefs and biases.</li>
</ul>
<h3>How to Improve</h3>
<ol>
  <li><strong>Ask Questions:</strong> Be curious and skeptical, not cynical.</li>
  <li><strong>Seek Evidence:</strong> Don�t rely on opinions�back ideas with facts.</li>
  <li><strong>Avoid Logical Fallacies:</strong> Learn to spot and avoid flawed arguments.</li>
  <li><strong>Think in Systems:</strong> Understand how parts interact in a bigger picture.</li>
</ol>
<h3>Conclusion</h3>
<p>Critical thinking is a lifelong skill that enhances decision-making, innovation, and leadership. The more you practice, the sharper your mind becomes in every aspect of life.</p>
', '2025-06-8', 200),
('Effective Communication Skills', 'Communication', 12, 'media/courses/image9.png',
'Master verbal and non-verbal communication in all contexts.',
'
<p>Effective communication is one of the most essential skills to succeed in both personal and professional life. It involves not just speaking clearly but also listening attentively, understanding non-verbal cues, and adapting your message to the audience.</p>
<h3>Why Communication Matters</h3>
<p>Communication is the foundation of all relationships and teamwork. When messages are conveyed clearly, misunderstandings reduce, productivity increases, and conflicts are minimized. Whether you''re giving a presentation, negotiating, or just having a casual conversation, your ability to communicate well directly impacts your success.</p>
<h3>Core Communication Skills</h3>
<ul>
  <li><strong>Active Listening:</strong> Pay full attention to the speaker, avoid interrupting, and provide feedback to confirm understanding.</li>
  <li><strong>Clear Articulation:</strong> Use simple language and avoid jargon unless necessary. Speak at a pace that is easy to follow.</li>
  <li><strong>Non-Verbal Communication:</strong> Body language, facial expressions, eye contact, and gestures all contribute to your message.</li>
  <li><strong>Empathy:</strong> Understand the emotions behind words and respond appropriately.</li>
</ul>
<h3>Tips to Improve Your Communication</h3>
<ol>
  <li><strong>Practice Active Listening:</strong> Instead of planning what to say next, focus fully on the speaker.</li>
  <li><strong>Be Clear and Concise:</strong> Avoid unnecessary details. Structure your message with a beginning, middle, and end.</li>
  <li><strong>Ask Questions:</strong> Clarify doubts to avoid assumptions.</li>
  <li><strong>Observe Reactions:</strong> Adjust your message if the listener looks confused or disengaged.</li>
  <li><strong>Give and Receive Feedback:</strong> Use constructive criticism to improve your skills.</li>
</ol>
<h3>Common Barriers to Communication</h3>
<p>Noise, cultural differences, emotional biases, and misunderstandings can hinder effective communication. Being aware of these barriers helps you navigate and overcome them.</p>
<h3>Conclusion</h3>
<p>Mastering communication skills takes time and conscious effort, but the benefits are immense � from stronger relationships to better career opportunities. Start with small daily practices, and you''ll see gradual improvement that transforms your interactions.</p>
', '2025-06-9', 300),
('Productivity & Planning Bootcamp', 'Time Management', 11, 'media/courses/image10.png',
'Get more done in less time with practical techniques.',
'
<p>Productivity isn�t about doing more�it�s about doing what matters most, efficiently and effectively. Planning plays a vital role in helping you align your time and energy with your goals.</p>
<h3>What Affects Productivity?</h3>
<p>Distractions, unclear priorities, and poor time management are major culprits. Understanding your habits and environment allows you to take control and improve focus.</p>
<h3>Essential Planning Skills</h3>
<ul>
  <li><strong>Goal Setting:</strong> Define clear, measurable objectives to stay motivated.</li>
  <li><strong>Prioritization:</strong> Use tools like the Eisenhower Matrix to focus on what�s truly important.</li>
  <li><strong>Time Blocking:</strong> Schedule tasks into specific time slots for better structure.</li>
  <li><strong>Review and Reflect:</strong> Regularly assess what�s working and adjust plans as needed.</li>
</ul>
<h3>Boosting Daily Productivity</h3>
<ol>
  <li><strong>Start with a Morning Routine:</strong> Set the tone for the day with focus and clarity.</li>
  <li><strong>Use a Planner or App:</strong> Track tasks, deadlines, and progress visually.</li>
  <li><strong>Eliminate Distractions:</strong> Turn off notifications and create a dedicated workspace.</li>
  <li><strong>Take Smart Breaks:</strong> Use techniques like Pomodoro to rest and recharge.</li>
</ol>
<h3>Conclusion</h3>
<p>Becoming more productive isn�t about perfection�it�s about intention. With the right mindset and systems, you can take control of your time, reduce stress, and achieve more of what truly matters.</p>
', '2025-06-10', 230);

--Course Additional
INSERT INTO CourseAdditional (CourseID, ContentURL, IsVideo, Caption, Content) VALUES
(1, 'media/blog/image1.png', 0, 'Team leadership with clear strategic direction', 'An illustration of a leadership team collaborating to develop and execute a well-defined strategy for organizational success.'),
(1, 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80', 0, 'Building an effective strategic vision', 'Strategic vision serves as a guiding compass, enabling organizations to set long-term goals and inspire collective efforts.'),
(1, 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=800&q=80', 0, 'Analyzing business context for leadership decisions', 'Effective leaders evaluate both internal and external business factors to make informed and sustainable strategic decisions.'),
(1, 'https://www.youtube.com/watch?v=iuYlGRnC7J8', 1, 'Video: Practical strategic leadership', 'This video explores real-world case studies and best practices in strategic leadership within dynamic business environments.'),
(2, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Organizing tasks with digital tools', 'Using task managers and calendars to prioritize effectively and reduce overwhelm.'),
(2, 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=800&q=80', 0, 'Time blocking technique in practice', 'Structuring daily schedules into dedicated blocks for focused work and rest.'),
(2, 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80', 0, 'Avoiding procrastination', 'Strategies to recognize distractions and build habits that boost productivity.'),
(2, 'https://www.youtube.com/watch?v=7M6bIeVbCqA', 1, 'Video: Productivity systems overview', 'Learn about GTD, Eisenhower Matrix, and Pomodoro in this visual guide.'),
(2, 'https://www.youtube.com/watch?v=T4dser6ssp0', 1, 'Video: Mastering time for results', 'Explore how successful professionals manage their day for maximum impact.'),
(3, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Mindfulness and reflection', 'Taking time to reflect on thoughts and emotions to build internal clarity.'),
(3, 'https://images.unsplash.com/photo-1531206715517-5c0ba140b2b8?auto=format&fit=crop&w=800&q=80', 0, 'Recognizing emotional triggers', 'Identifying patterns in reactions to improve emotional regulation.'),
(3, 'https://images.unsplash.com/photo-1504196606672-aef5c9cefc92?auto=format&fit=crop&w=800&q=80', 0, 'Personal values discovery', 'Exploring what truly matters to align behavior with core beliefs.'),
(3, 'https://www.youtube.com/watch?v=tGdsOXZpyWE', 1, 'Video: Building self-awareness', 'Understand self-perception and how it shapes leadership and growth.'),
(3, 'https://www.youtube.com/watch?v=4lTbWQ8zD3w', 1, 'Video: The power of knowing yourself', 'A TED-style talk exploring how introspection boosts performance.'),
(4, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Speaking with confidence', 'Body language, eye contact, and tone all play a role in compelling delivery.'),
(4, 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=800&q=80', 0, 'Engaging your audience', 'Techniques to keep listeners interested and involved.'),
(4, 'https://images.unsplash.com/photo-1581090700227-1e37b190418e?auto=format&fit=crop&w=800&q=80', 0, 'Overcoming stage fear', 'Practical ways to manage anxiety before and during speeches.'),
(4, 'https://www.youtube.com/watch?v=CAU2zx2Ri_M', 1, 'Video: Public speaking tips', 'Learn how to structure and deliver a persuasive presentation.'),
(4, 'https://www.youtube.com/watch?v=ZmNpeXTj2c4', 1, 'Video: Storytelling in speeches', 'Use storytelling to make your message stick.'),
(5, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Inspiring team vision', 'Foundational leadership starts with communicating a compelling mission.'),
(5, 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?auto=format&fit=crop&w=800&q=80', 0, 'Guiding with empathy', 'Great leaders listen actively and support team development.'),
(5, 'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?auto=format&fit=crop&w=800&q=80', 0, 'Leading by example', 'Demonstrating integrity and professionalism sets the tone.'),
(5, 'https://www.youtube.com/watch?v=Z9MHrLrzBfI', 1, 'Video: What makes a leader', 'A breakdown of essential qualities new leaders need.'),
(5, 'https://www.youtube.com/watch?v=NQN4mtTagL0', 1, 'Video: Leadership in action', 'See how effective leaders influence teams and culture.'),
(6, 'media/blog/image1.png', 0, 'Understanding emotional cues', 'Recognizing non-verbal signals to foster empathy and clarity.'),
(6, 'media/blog/image2.png', 0, 'Responding vs. reacting', 'Learning to pause and choose mindful responses in workplace scenarios.'),
(6, 'media/blog/image3.png', 0, 'Team emotional climate', 'How leaders set the emotional tone of their teams.'),
(6, 'https://www.youtube.com/watch?v=LgUCyWhJf6s', 1, 'Video: Emotional intelligence explained', 'Daniel Goleman�s breakdown of EQ in the workplace.'),
(6, 'https://www.youtube.com/watch?v=6bbLWsvDW5o', 1, 'Video: EQ for leaders', 'Learn how EQ affects communication, motivation, and collaboration.'),
(7, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Group brainstorming for complex problems', 'Collaborative sessions help uncover creative solutions through diverse perspectives.'),
(7, 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=800&q=80', 0, 'Breaking down challenges step-by-step', 'Systematic analysis enables better understanding and structured problem resolution.'),
(7, 'https://images.unsplash.com/photo-1560264418-c4445382edbc?auto=format&fit=crop&w=800&q=80', 0, 'Using frameworks like 5 Whys and Fishbone', 'Popular techniques assist in root cause identification.'),
(7, 'https://www.youtube.com/watch?v=7kPrLMchT5o', 1, 'Video: Solving real-world business challenges', 'Watch teams apply frameworks to practical case studies.'),
(7, 'https://www.youtube.com/watch?v=RSXyw0UMOpQ', 1, 'Video: Structured problem-solving process', 'Step-by-step video tutorial on practical application of structured thinking.'),
(8, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Evaluating arguments with logic', 'Use logic to dissect arguments and distinguish fact from opinion.'),
(8, 'media/blog/image4.png', 0, 'Critical thinking in group decisions', 'Applying objectivity and clarity during collaborative choices.'),
(8, 'media/blog/image5.png', 0, 'Identifying hidden biases', 'Recognizing how assumptions affect judgment and reasoning.'),
(8, 'https://www.youtube.com/watch?v=dItUGF8GdTw', 1, 'Video: Introduction to critical thinking', 'Foundations of reasoning, evidence, and skeptical inquiry.'),
(8, 'https://www.youtube.com/watch?v=wwUe7T2OKQE', 1, 'Video: Spotting flawed arguments', 'Analyzing logical fallacies in real-life conversations and media.'),
(9, 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80', 0, 'Delivering clear and engaging messages', 'Communicate your ideas in a structured and relatable way.'),
(9, 'media/blog/image6.png', 0, 'Active listening in team meetings', 'Truly hearing others to strengthen collaboration and trust.'),
(9, 'media/blog/image7.png', 0, 'Adapting tone and body language', 'Effective use of nonverbal cues and situational communication.'),
(9, 'https://www.youtube.com/watch?v=7hr60EumwQ4', 1, 'Video: Mastering professional communication', 'Skills for confident, respectful, and persuasive conversations.'),
(9, 'https://www.youtube.com/watch?v=m79fQpy8mYk', 1, 'Video: Communication do�s and don�ts', 'Common mistakes and how to speak clearly and assertively.'),
(10, 'media/blog/image8.png', 0, 'Setting priorities with clear goals', 'Define what matters most to stay focused and effective.'),
(10, 'media/blog/image9.png', 0, 'Planning with digital tools and calendars', 'Use apps and systems to manage time and avoid overload.'),
(10, 'media/blog/image10.png', 0, 'Daily review and reflection routines', 'Consistency and reflection enhance daily progress.'),
(10, 'https://www.youtube.com/watch?v=iONDebHX9qk', 1, 'Video: Time management hacks', 'Productivity techniques used by high performers.'),
(10, 'https://www.youtube.com/watch?v=J1qiCdrXHgU', 1, 'Video: Planning smarter, not harder', 'Learn to plan your day based on energy and focus zones.');

--Course Package
INSERT INTO CoursePackage (CourseID, PackageName, OriginalPrice, SaleRate, UseTime, Description) 
VALUES
(1, 'Basic', 1200000, 50, 90, 'Course materials, No extra resources, No certificate'),
(1, 'Standard', 1600000, 30, 180, 'Course materials, Extra resources, No certificate'),
(1, 'Premium', 2000000, 30, 0, 'Course materials, Extra resources, Certificate included'),
(2, 'Basic', 1000000, 50, 90, 'Core lessons, No worksheets, No certificate'),
(2, 'Standard', 1400000, 43, 180, 'Lessons + worksheets, No certificate'),
(2, 'Premium', 1800000, 33, 0, 'Full program, Worksheets, Certificate included'),
(3, 'Basic', 800000, 50, 90, 'Core access, No journaling, No certificate'),
(3, 'Standard', 1200000, 42, 180, 'Journaling tools, No certificate'),
(3, 'Premium', 1600000, 31, 0, 'Full tools, Journaling, Certificate included'),
(4, 'Basic', 900000, 49, 90, 'Basic tips, No interaction, No certificate'),
(4, 'Standard', 1300000, 38, 180, 'Interactive exercises, No certificate'),
(4, 'Premium', 1700000, 29, 0, 'Advanced content, Certificate included'),
(5, 'Basic', 1100000, 49, 90, 'Essential lessons, No team tools, No certificate'),
(5, 'Standard', 1500000, 40, 180, 'Includes team tools, No certificate'),
(5, 'Premium', 1900000, 32, 0, 'Mentorship + tools, Certificate included'),
(6, 'Basic', 850000, 49, 90, 'Basic EI, No coaching, No certificate'),
(6, 'Standard', 1250000, 41, 180, 'Coaching included, No certificate'),
(6, 'Premium', 1650000, 29, 0, 'Coaching + tools, Certificate included'),
(7, 'Basic', 800000, 50, 90, 'Toolkit access, No case studies, No certificate'),
(7, 'Standard', 1200000, 43, 180, 'Includes case studies, No certificate'),
(7, 'Premium', 1600000, 33, 0, 'Case studies + 1:1 help, Certificate included'),
(8, 'Basic', 850000, 50, 90, 'Quick access, No practice tests, No certificate'),
(8, 'Standard', 1250000, 42, 180, 'Practice tests included, No certificate'),
(8, 'Premium', 1650000, 32, 0, 'Tests + coaching, Certificate included'),
(9, 'Basic', 970000, 50, 90, 'Starter pack, No tasks, No certificate'),
(9, 'Standard', 1370000, 41, 180, 'Includes dialogues, No certificate'),
(9, 'Premium', 1770000, 32, 0, 'Live demo + tasks, Certificate included'),
(10, 'Basic', 880000, 50, 90, 'Basic planner, No tools, No certificate'),
(10, 'Standard', 1280000, 39, 180, 'Includes tools, No certificate'),
(10, 'Premium', 1680000, 31, 0, 'Full tools + support, Certificate included');

-- CourseReview
INSERT INTO CourseReview (UserID, CourseID, IsRecommended, Comment, CreatedAt) VALUES
(6, 1, 1, 'Well-structured and easy to follow.', '2025-06-03 02:42:24'),
(1, 1, 0, 'Great course with practical insights.', '2024-08-23 02:42:24'),
(2, 1, 0, 'Loved the interactivity and exercises.', '2025-01-19 02:42:24'),
(10, 1, 1, 'Excellent delivery by the instructor.', '2025-02-20 02:42:24'),
(3, 1, 1, 'I learned a lot and improved my skills.', '2025-06-03 02:42:24'),
(5, 1, 1, 'Loved the interactivity and exercises.', '2024-07-07 02:42:24'),
(10, 2, 0, 'Would recommend to others looking to grow.', '2025-02-09 02:42:24'),
(2, 2, 0, 'Good pace and clear explanations.', '2024-12-21 02:42:24'),
(6, 2, 1, 'Excellent delivery by the instructor.', '2024-10-08 02:42:24'),
(9, 2, 1, 'Loved the interactivity and exercises.', '2024-09-23 02:42:24'),
(5, 2, 1, 'Informative and engaging from start to finish.', '2024-06-26 02:42:24'),
(3, 2, 0, 'Great course with practical insights.', '2024-08-26 02:42:24'),
(5, 3, 0, 'Would recommend to others looking to grow.', '2024-12-18 02:42:24'),
(1, 3, 1, 'Informative and engaging from start to finish.', '2024-11-16 02:42:24'),
(10, 3, 0, 'Loved the interactivity and exercises.', '2024-10-23 02:42:24'),
(8, 3, 1, 'Great course with practical insights.', '2024-08-14 02:42:24'),
(6, 3, 1, 'Well-structured and easy to follow.', '2024-07-07 02:42:24'),
(2, 3, 1, 'Excellent delivery by the instructor.', '2024-06-28 02:42:24'),
(3, 4, 1, 'Informative and engaging from start to finish.', '2025-01-28 02:42:24'),
(6, 4, 1, 'Loved the interactivity and exercises.', '2024-10-05 02:42:24'),
(5, 4, 1, 'Excellent delivery by the instructor.', '2024-09-21 02:42:24'),
(9, 4, 0, 'Some parts felt rushed, but valuable content.', '2024-09-01 02:42:24'),
(7, 4, 1, 'Well-structured and easy to follow.', '2024-06-29 02:42:24'),
(10, 4, 0, 'Could use more real-world examples, but overall helpful.', '2025-04-19 02:42:24'),
(10, 5, 1, 'Well-structured and easy to follow.', '2024-07-27 02:42:24'),
(1, 5, 0, 'Loved the interactivity and exercises.', '2024-06-24 02:42:24'),
(8, 5, 1, 'Great course with practical insights.', '2024-07-19 02:42:24'),
(9, 5, 1, 'Good pace and clear explanations.', '2024-11-13 02:42:24'),
(4, 5, 1, 'Excellent delivery by the instructor.', '2024-12-07 02:42:24'),
(5, 5, 0, 'I learned a lot and improved my skills.', '2024-09-09 02:42:24'),
(7, 6, 0, 'Excellent delivery by the instructor.', '2024-09-10 02:42:24'),
(2, 6, 1, 'Loved the interactivity and exercises.', '2024-10-30 02:42:24'),
(6, 6, 1, 'Great course with practical insights.', '2024-06-27 02:42:24'),
(3, 6, 0, 'Informative and engaging from start to finish.', '2025-01-12 02:42:24'),
(1, 6, 1, 'Well-structured and easy to follow.', '2024-08-09 02:42:24'),
(9, 6, 1, 'Good pace and clear explanations.', '2025-02-01 02:42:24'),
(6, 7, 0, 'Some parts felt rushed, but valuable content.', '2024-09-16 02:42:24'),
(2, 7, 1, 'Excellent delivery by the instructor.', '2024-10-01 02:42:24'),
(10, 7, 1, 'Would recommend to others looking to grow.', '2025-04-25 02:42:24'),
(3, 7, 1, 'Loved the interactivity and exercises.', '2025-05-01 02:42:24'),
(5, 7, 1, 'Great course with practical insights.', '2024-06-21 02:42:24'),
(7, 7, 0, 'Could use more real-world examples, but overall helpful.', '2024-07-14 02:42:24'),
(4, 8, 1, 'Informative and engaging from start to finish.', '2024-11-24 02:42:24'),
(7, 8, 0, 'Great course with practical insights.', '2024-10-13 02:42:24'),
(8, 8, 1, 'Loved the interactivity and exercises.', '2024-08-18 02:42:24'),
(2, 8, 0, 'Excellent delivery by the instructor.', '2024-07-03 02:42:24'),
(6, 8, 1, 'Good pace and clear explanations.', '2024-07-31 02:42:24'),
(3, 8, 1, 'Some parts felt rushed, but valuable content.', '2024-09-12 02:42:24'),
(4, 9, 1, 'Loved the interactivity and exercises.', '2025-03-09 02:42:24'),
(8, 9, 1, 'Informative and engaging from start to finish.', '2024-07-17 02:42:24'),
(1, 9, 1, 'Excellent delivery by the instructor.', '2025-05-20 02:42:24'),
(5, 9, 0, 'Could use more real-world examples, but overall helpful.', '2024-08-28 02:42:24'),
(9, 9, 1, 'Great course with practical insights.', '2024-12-01 02:42:24'),
(7, 9, 0, 'Well-structured and easy to follow.', '2025-01-07 02:42:24'),
(4, 10, 1, 'Loved the interactivity and exercises.', '2025-03-09 02:42:24'),
(8, 10, 1, 'Informative and engaging from start to finish.', '2024-07-17 02:42:24'),
(1, 10, 1, 'Excellent delivery by the instructor.', '2025-05-20 02:42:24'),
(5, 10, 0, 'Could use more real-world examples, but overall helpful.', '2024-08-28 02:42:24'),
(9, 10, 1, 'Great course with practical insights.', '2024-12-01 02:42:24'),
(7, 10, 0, 'Well-structured and easy to follow.', '2025-01-07 02:42:24');

--Course Review Media
INSERT INTO CourseReviewMedia (ReviewID, MediaURL, IsVideo, Caption) VALUES
(1, 'media/courseReview/course_img1.png', 0, 'Overview of the first lecture slide.'),
(1, 'media/courseReview/course_img2.png', 0, 'Group discussion during class.'),
(1, 'media/courseReview/course_video.mp4', 1, 'Video summary of the key lecture.'),
(2, 'media/courseReview/course_img3.png', 0, 'Online classroom environment.'),
(2, 'media/courseReview/course_img4.png', 0, 'Course materials shared by instructor.'),
(2, 'media/courseReview/course_video.mp4', 1, 'Student testimonial about the course.'),
(7, 'media/courseReview/course_img1.png', 0, 'Interactive session screenshot.'),
(7, 'media/courseReview/course_img2.png', 0, 'Class activity on critical thinking.'),
(7, 'media/courseReview/course_video.mp4', 1, 'Course demo video.'),
(8, 'media/courseReview/course_img3.png', 0, 'Team project presentation.'),
(8, 'media/courseReview/course_img4.png', 0, 'Students sharing ideas.'),
(8, 'media/courseReview/course_video.mp4', 1, 'Recap of key concepts.'),
(13, 'media/courseReview/course_img1.png', 0, 'First session highlights.'),
(13, 'media/courseReview/course_img2.png', 0, 'Live Q&A with the trainer.'),
(13, 'media/courseReview/course_video.mp4', 1, 'Course highlight reel.'),
(14, 'media/courseReview/course_img3.png', 0, 'Interactive group task.'),
(14, 'media/courseReview/course_img4.png', 0, 'Brainstorming session snapshot.'),
(14, 'media/courseReview/course_video.mp4', 1, 'Trainer�s feedback video.'),
(19, 'media/courseReview/course_img1.png', 0, 'Engaging workshop setup.'),
(19, 'media/courseReview/course_img2.png', 0, 'Team discussion in breakout room.'),
(19, 'media/courseReview/course_video.mp4', 1, 'Workshop recap clip.'),
(20, 'media/courseReview/course_img3.png', 0, 'Hands-on activity during class.'),
(20, 'media/courseReview/course_img4.png', 0, 'Whiteboard explanation by instructor.'),
(20, 'media/courseReview/course_video.mp4', 1, 'Student learning reflection.'),
(25, 'media/courseReview/course_img1.png', 0, 'Slide on leadership techniques.'),
(25, 'media/courseReview/course_img2.png', 0, 'Role-playing exercise.'),
(25, 'media/courseReview/course_video.mp4', 1, 'Leadership skills in action.'),
(26, 'media/courseReview/course_img3.png', 0, 'Group presentation moment.'),
(26, 'media/courseReview/course_img4.png', 0, 'Class wrap-up discussion.'),
(26, 'media/courseReview/course_video.mp4', 1, 'Course reflection by attendees.'),
(31, 'media/courseReview/course_img1.png', 0, 'Trainer introducing the module.'),
(31, 'media/courseReview/course_img2.png', 0, 'Note-taking during lecture.'),
(31, 'media/courseReview/course_video.mp4', 1, 'Video clip from lesson 1.'),
(32, 'media/courseReview/course_img3.png', 0, 'In-class activity snapshot.'),
(32, 'media/courseReview/course_img4.png', 0, 'Final assignment overview.'),
(32, 'media/courseReview/course_video.mp4', 1, 'Summary of key takeaways.'),
(37, 'media/courseReview/course_img1.png', 0, 'Classroom icebreaker activity.'),
(37, 'media/courseReview/course_img2.png', 0, 'Collaborative group work.'),
(37, 'media/courseReview/course_video.mp4', 1, 'Video montage of sessions.'),
(38, 'media/courseReview/course_img3.png', 0, 'Student feedback board.'),
(38, 'media/courseReview/course_img4.png', 0, 'Discussion about project ideas.'),
(38, 'media/courseReview/course_video.mp4', 1, 'Closing speech by instructor.'),
(43, 'media/courseReview/course_img1.png', 0, 'Introduction to course agenda.'),
(43, 'media/courseReview/course_img2.png', 0, 'Student interaction in breakout room.'),
(43, 'media/courseReview/course_video.mp4', 1, 'Participant�s learning experience.'),
(44, 'media/courseReview/course_img3.png', 0, 'Live feedback session.'),
(44, 'media/courseReview/course_img4.png', 0, 'Instructor answering questions.'),
(44, 'media/courseReview/course_video.mp4', 1, 'Course completion moments.'),
(49, 'media/courseReview/course_img1.png', 0, 'Class starting slide.'),
(49, 'media/courseReview/course_img2.png', 0, 'Peer evaluation activity.'),
(49, 'media/courseReview/course_video.mp4', 1, 'Highlights of the final session.'),
(50, 'media/courseReview/course_img3.png', 0, 'Presentation of final project.'),
(50, 'media/courseReview/course_img4.png', 0, 'Post-course discussion.'),
(50, 'media/courseReview/course_video.mp4', 1, 'Thank-you message from trainer.');

-- Slider image (homepage)
INSERT INTO SliderImage (SliderID,CourseID, SliderTitle, SliderContent, SliderURL, Status)
VALUES
(1,4, 'Boost Your Confidence in Public Speaking', 'Learn practical tips and techniques to overcome stage fright and speak clearly.', 'media/sliders/image1.png', 1),
(2,2, 'Master Time Management Today', 'Prioritize what matters and reclaim your hours with proven time strategies.', 'media/sliders/image2.png', 1),
(3,6, 'Enhance Your EQ for Workplace Success', 'Emotional intelligence improves teamwork, communication, and leadership.', 'media/sliders/image3.png', 0),
(4,7, 'Become a Pro at Problem Solving', 'Tackle complex problems with confidence using structured problem-solving tools.', 'media/sliders/image4.png', 1);
