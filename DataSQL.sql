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
<p>Mastering communication skills takes time and conscious effort, but the benefits are immense — from stronger relationships to better career opportunities. Start with small daily practices, and you\ll see gradual improvement that transforms your interactions.</p>
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
  <li><strong>Use the Eisenhower Matrix:</strong> Categorize tasks by urgency and importance. Focus on “important and urgent” first, then “important but not urgent.”</li>
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
  <li>Set “do not disturb” periods.</li>
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
<p>Put yourself in others\shoes by actively listening without judgment. Validate others’ feelings to build trust and rapport.</p>

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
<p>Emotional intelligence is not a fixed trait — it can be developed with conscious effort. Enhancing your EI can transform your personal relationships and professional interactions, leading to a more fulfilling and successful life.</p>
'),
(4, '
<p>Effective leadership is a combination of habits, mindset, and skills that inspire others to achieve common goals. Great leaders don’t just give orders; they motivate, empower, and set examples.</p>

<h3>Understanding Leadership</h3>
<p>Leadership goes beyond managing tasks—it\s about influencing people positively. Whether you lead a small team or a large organization, your daily habits shape the culture and productivity of your group.</p>

<h3>Daily Habits of Successful Leaders</h3>
<ul>
  <li><strong>Clear Communication:</strong> Consistently share vision and expectations with clarity.</li>
  <li><strong>Active Listening:</strong> Pay attention to team members’ ideas and concerns.</li>
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
<p>Every organization faces challenges—from technical issues to interpersonal conflicts. Being able to address problems promptly minimizes disruption and drives success.</p>

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
  <li><strong>Root Cause Analysis (5 Whys):</strong> Ask “why” repeatedly to drill down to the cause.</li>
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
  <li>Put yourself in others’ shoes before making decisions.</li>
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
  <li><strong>Set Long-Term Goals:</strong> Think beyond quarterly targets and envision where your team should be in 3–5 years.</li>
  <li><strong>Engage Stakeholders:</strong> Collaborate with team members, investors, and customers to create shared goals.</li>
  <li><strong>Reflect & Adapt:</strong> Regularly evaluate outcomes and adjust strategies as needed.</li>
</ol>
<h3>Conclusion</h3>
<p>Strategic leadership is a powerful skill that combines vision, influence, and execution. By learning how to lead strategically, you position yourself and your organization for sustainable growth and success.</p>
', '2025-06-1', 240),
('Time Management Mastery', 'Time Management', 10, 'media/courses/image2.png',
'Organize your schedule and manage priorities efficiently.',
'
<p>Time management is more than just filling out a planner—it''s about intentionally allocating your time to achieve meaningful goals while maintaining balance. In a world of distractions and busy schedules, mastering your time is the key to reducing stress and increasing productivity.</p>
<h3>Why Time Management Matters</h3>
<p>When you manage your time effectively, you’re in control of your life. You can prioritize tasks, meet deadlines, and have space left for personal growth and relaxation. Without good time habits, even the most talented individuals can feel overwhelmed and underperform.</p>
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
  <li><strong>Review & Reflect:</strong> End each day or week by reviewing what worked and what didn’t.</li>
</ol>
<h3>Conclusion</h3>
<p>Mastering time management is a lifelong journey. With practice and discipline, you can reduce stress, boost productivity, and create more space for the things that truly matter.</p>
', '2025-06-2', 250),
('Mastering Self-Awareness', 'Emotional Intelligence', 7, 'media/courses/image3.png',
'Understand and manage your emotions effectively.',
'
<p>Self-awareness is the foundation of emotional intelligence, strong leadership, and meaningful relationships. It’s about recognizing your thoughts, emotions, and behaviors—and understanding how they affect yourself and others.</p>
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
<p>Greater self-awareness leads to better emotional regulation, stronger communication, and more effective leadership. It also fosters humility and openness to learning—essential traits in any successful career.</p>
<h3>Conclusion</h3>
<p>Self-awareness is not a destination but a continuous journey. The more you learn about yourself, the more empowered you become to make conscious choices that align with your values and purpose.</p>
', '2025-06-3', 190),
('Public Speaking Essentials', 'Communication', 8, 'media/courses/image4.png',
'Become a confident public speaker with real-world tips.',
'
<p>Public speaking is a skill that can open doors to new opportunities, whether youre delivering a presentation, pitching an idea, or leading a team. It’s not just about talking—it’s about connecting, persuading, and inspiring your audience.</p>
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
<p>Leadership is more than a job title—it’s about guiding others toward a shared vision and helping them thrive along the way. Whether you''re new to a leadership role or looking to refine your style, understanding the fundamentals is crucial.</p>
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
<p>Emotional intelligence (EQ) is the ability to recognize, understand, and manage your emotions—and to do the same with others. At work, EQ helps you navigate relationships, lead with empathy, and handle stress effectively.</p>
<h3>Why EQ is Crucial in the Workplace</h3>
<p>High EQ enhances teamwork, improves communication, and increases job satisfaction. Employees with strong emotional intelligence are better problem solvers, conflict managers, and collaborators.</p>
<h3>The Five Elements of EQ</h3>
<ul>
  <li><strong>Self-Awareness:</strong> Recognizing your emotions and their impact on your behavior.</li>
  <li><strong>Self-Regulation:</strong> Managing your impulses, moods, and reactions.</li>
  <li><strong>Motivation:</strong> Staying driven and focused on goals despite setbacks.</li>
  <li><strong>Empathy:</strong> Understanding others’ emotions and responding with compassion.</li>
  <li><strong>Social Skills:</strong> Building relationships, resolving conflicts, and influencing positively.</li>
</ul>
<h3>Ways to Build EQ at Work</h3>
<ol>
  <li><strong>Practice Mindfulness:</strong> Pause and observe your emotional state before reacting.</li>
  <li><strong>Use "I" Statements:</strong> Express how you feel without blaming others.</li>
  <li><strong>Learn to Listen:</strong> Give your full attention and reflect back what you hear.</li>
  <li><strong>Stay Curious:</strong> Ask questions and show genuine interest in others’ perspectives.</li>
</ol>
<h3>Conclusion</h3>
<p>Emotional intelligence isn’t fixed—it can be developed with awareness and practice. By honing your EQ, you can improve your work relationships, boost performance, and create a more positive and productive environment.</p>
', '2025-06-6', 210),
('Problem Solving Techniques', 'Problem Solving', 11, 'media/courses/image7.png',
'Approach and resolve complex issues logically.',
'
<p>Problem solving is a core skill in today’s dynamic world. Whether you’re in business, education, or daily life, the ability to approach challenges methodically and creatively makes all the difference.</p>
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
<p>Critical thinking is the ability to objectively analyze information and make reasoned judgments. It’s essential for navigating complex information and avoiding cognitive biases.</p>
<h3>What is Critical Thinking?</h3>
<p>It involves evaluating evidence, questioning assumptions, and identifying logical connections. Critical thinkers don’t accept information at face value—they ask “why,” “how,” and “what else?”</p>
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
  <li><strong>Seek Evidence:</strong> Don’t rely on opinions—back ideas with facts.</li>
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
<p>Mastering communication skills takes time and conscious effort, but the benefits are immense — from stronger relationships to better career opportunities. Start with small daily practices, and you''ll see gradual improvement that transforms your interactions.</p>
', '2025-06-9', 300),
('Productivity & Planning Bootcamp', 'Time Management', 11, 'media/courses/image10.png',
'Get more done in less time with practical techniques.',
'
<p>Productivity isn’t about doing more—it’s about doing what matters most, efficiently and effectively. Planning plays a vital role in helping you align your time and energy with your goals.</p>
<h3>What Affects Productivity?</h3>
<p>Distractions, unclear priorities, and poor time management are major culprits. Understanding your habits and environment allows you to take control and improve focus.</p>
<h3>Essential Planning Skills</h3>
<ul>
  <li><strong>Goal Setting:</strong> Define clear, measurable objectives to stay motivated.</li>
  <li><strong>Prioritization:</strong> Use tools like the Eisenhower Matrix to focus on what’s truly important.</li>
  <li><strong>Time Blocking:</strong> Schedule tasks into specific time slots for better structure.</li>
  <li><strong>Review and Reflect:</strong> Regularly assess what’s working and adjust plans as needed.</li>
</ul>
<h3>Boosting Daily Productivity</h3>
<ol>
  <li><strong>Start with a Morning Routine:</strong> Set the tone for the day with focus and clarity.</li>
  <li><strong>Use a Planner or App:</strong> Track tasks, deadlines, and progress visually.</li>
  <li><strong>Eliminate Distractions:</strong> Turn off notifications and create a dedicated workspace.</li>
  <li><strong>Take Smart Breaks:</strong> Use techniques like Pomodoro to rest and recharge.</li>
</ol>
<h3>Conclusion</h3>
<p>Becoming more productive isn’t about perfection—it’s about intention. With the right mindset and systems, you can take control of your time, reduce stress, and achieve more of what truly matters.</p>
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
(6, 'https://www.youtube.com/watch?v=LgUCyWhJf6s', 1, 'Video: Emotional intelligence explained', 'Daniel Goleman’s breakdown of EQ in the workplace.'),
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
(9, 'https://www.youtube.com/watch?v=m79fQpy8mYk', 1, 'Video: Communication do’s and don’ts', 'Common mistakes and how to speak clearly and assertively.'),
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
(14, 'media/courseReview/course_video.mp4', 1, 'Trainer’s feedback video.'),
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
(43, 'media/courseReview/course_video.mp4', 1, 'Participant’s learning experience.'),
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
INSERT INTO SliderImage (CourseID, SliderTitle, SliderContent, SliderURL, Status)
VALUES
(4, 'Boost Your Confidence in Public Speaking', 'Learn practical tips and techniques to overcome stage fright and speak clearly.', 'media/sliders/image1.png', 1),
(2, 'Master Time Management Today', 'Prioritize what matters and reclaim your hours with proven time strategies.', 'media/sliders/image2.png', 1),
(6, 'Enhance Your EQ for Workplace Success', 'Emotional intelligence improves teamwork, communication, and leadership.', 'media/sliders/image3.png', 0),
(7, 'Become a Pro at Problem Solving', 'Tackle complex problems with confidence using structured problem-solving tools.', 'media/sliders/image4.png', 1);

INSERT INTO Chapter (CourseID, Title, ChapterOrder, Status) VALUES
-- Chapters for 'Strategic Leadership' (CourseID 1)
(1, 'Foundations of Strategic Leadership', 1, 1),
(1, 'Developing Vision and Strategy', 2, 1),
(1, 'Executing and Adapting Strategy', 3, 1),

-- Chapters for 'Time Management Mastery' (CourseID 2)
(2, 'Understanding Time and Priorities', 1, 1),
(2, 'Effective Planning and Techniques', 2, 1),
(2, 'Overcoming Obstacles to Productivity', 3, 1),

-- Chapters for 'Mastering Self-Awareness' (CourseID 3)
(3, 'Basics of Self-Awareness', 1, 1),
(3, 'Developing Internal Awareness', 2, 1),
(3, 'Applying Self-Awareness in Life', 3, 1),

-- Chapters for 'Public Speaking Essentials' (CourseID 4)
(4, 'Preparation and Audience Analysis', 1, 1),
(4, 'Structuring and Delivering Your Message', 2, 1),
(4, 'Handling Nerves and Engaging Audience', 3, 1),

-- Chapters for 'Leadership Fundamentals' (CourseID 5)
(5, 'The Essence of Leadership', 1, 1),
(5, 'Key Leadership Skills', 2, 1),
(5, 'Building and Inspiring Your Team', 3, 1),
(5, 'Leading Through Challenges', 4, 1),

-- Chapters for 'Emotional Intelligence at Work' (CourseID 6)
(6, 'Introduction to Emotional Intelligence', 1, 1),
(6, 'Self-Management and Awareness', 2, 1),
(6, 'Social Awareness and Relationship Management', 3, 1),

-- Chapters for 'Problem Solving Techniques' (CourseID 7)
(7, 'Defining and Analyzing Problems', 1, 1),
(7, 'Generating and Evaluating Solutions', 2, 1),
(7, 'Implementing and Reviewing Solutions', 3, 1),

-- Chapters for 'Critical Thinking Skills' (CourseID 8)
(8, 'Foundations of Critical Thinking', 1, 1),
(8, 'Analyzing Arguments and Evidence', 2, 1),
(8, 'Making Informed Decisions', 3, 1),

-- Chapters for 'Effective Communication Skills' (CourseID 9)
(9, 'Fundamentals of Communication', 1, 1),
(9, 'Verbal and Non-Verbal Communication', 2, 1),
(9, 'Listening and Feedback Skills', 3, 1),
(9, 'Advanced Communication Strategies', 4, 1),

-- Chapters for 'Productivity & Planning Bootcamp' (CourseID 10)
(10, 'Understanding Productivity Basics', 1, 1),
(10, 'Goal Setting and Prioritization', 2, 1),
(10, 'Advanced Planning and Execution', 3, 1);




INSERT INTO Lesson (ChapterID, Title, IsFree, LessonOrder, Status) VALUES
(1, 'Welcome to Strategic Leadership', 1, 1, 1),
(1, 'The Importance of Strategic Thinking', 0, 2, 1),
(1, 'Key Concepts of Strategic Leadership', 0, 3, 1),
(2, 'Crafting a Compelling Vision', 0, 1, 1),
(2, 'Strategic Goal Setting', 0, 2, 1),
(2, 'SWOT Analysis for Leaders', 0, 3, 1),
(2, 'Developing Strategic Initiatives', 0, 4, 1),
(3, 'Aligning Teams with Strategy', 0, 1, 1),
(3, 'Monitoring and Evaluation', 0, 2, 1),
(3, 'Adapting to Market Changes', 0, 3, 1),
(4, 'Introduction to Time Management', 1, 1, 1),
(4, 'Identifying Your Time Wasters', 0, 2, 1),
(4, 'The Power of Prioritization', 0, 3, 1),
(5, 'Setting Effective Goals (SMART)', 0, 1, 1),
(5, 'Time Blocking and Scheduling', 0, 2, 1),
(5, 'The Pomodoro Technique Explained', 0, 3, 1),
(5, 'Creating Effective To-Do Lists', 0, 4, 1),
(6, 'Dealing with Distractions', 0, 1, 1),
(6, 'Overcoming Procrastination', 0, 2, 1),
(6, 'Delegation Skills', 0, 3, 1),
(7, 'What is Self-Awareness and Why it Matters?', 1, 1, 1),
(7, 'Internal vs. External Self-Awareness', 0, 2, 1),
(8, 'Journaling for Self-Discovery', 0, 1, 1),
(8, 'Mindfulness Practices for Awareness', 0, 2, 1),
(8, 'Understanding Your Values and Beliefs', 0, 3, 1),
(9, 'Seeking and Receiving Feedback Effectively', 0, 1, 1),
(9, 'Managing Your Emotions with Awareness', 0, 2, 1),
(10, 'Understanding Your Audience', 1, 1, 1),
(10, 'Defining Your Message and Purpose', 0, 2, 1),
(10, 'Structuring Your Presentation', 0, 3, 1),
(11, 'Crafting Engaging Introductions and Conclusions', 0, 1, 1),
(11, 'Using Visual Aids Effectively', 0, 2, 1),
(11, 'Vocal Delivery and Body Language', 0, 3, 1),
(12, 'Managing Public Speaking Anxiety', 0, 1, 1),
(12, 'Techniques for Audience Engagement', 0, 2, 1),
(13, 'What Defines a Leader?', 1, 1, 1),
(13, 'Leadership Styles and Their Impact', 0, 2, 1),
(14, 'Effective Communication for Leaders', 0, 1, 1),
(14, 'Decision Making in Leadership', 0, 2, 1),
(14, 'Delegation and Empowerment', 0, 3, 1),
(15, 'Motivating and Inspiring Your Team', 0, 1, 1),
(15, 'Conflict Resolution in Teams', 0, 2, 1),
(16, 'Leading Through Change', 0, 1, 1),
(16, 'Resilience in Leadership', 0, 2, 1),
(17, 'Understanding Emotional Intelligence (EQ)', 1, 1, 1),
(17, 'Why EQ Matters in the Workplace', 0, 2, 1),
(18, 'Developing Self-Awareness at Work', 0, 1, 1),
(18, 'Strategies for Self-Regulation', 0, 2, 1),
(19, 'Practicing Empathy in Professional Settings', 0, 1, 1),
(19, 'Building Strong Work Relationships', 0, 2, 1),
(20, 'Introduction to Problem Solving', 1, 1, 1),
(20, 'Defining the Problem Clearly', 0, 2, 1),
(20, 'Root Cause Analysis (5 Whys)', 0, 3, 1),
(21, 'Brainstorming Techniques', 0, 1, 1),
(21, 'Evaluating Potential Solutions', 0, 2, 1),
(22, 'Action Planning and Implementation', 0, 1, 1),
(22, 'Monitoring and Adapting Solutions', 0, 2, 1),
(23, 'What is Critical Thinking?', 1, 1, 1),
(23, 'The Importance of Objective Analysis', 0, 2, 1),
(24, 'Identifying Arguments and Premises', 0, 1, 1),
(24, 'Evaluating Evidence and Sources', 0, 2, 1),
(25, 'Recognizing Cognitive Biases', 0, 1, 1),
(25, 'Applying Critical Thinking to Decision Making', 0, 2, 1),
(26, 'The Communication Process', 1, 1, 1),
(26, 'Barriers to Effective Communication', 0, 2, 1),
(27, 'Mastering Verbal Communication', 0, 1, 1),
(27, 'Understanding Non-Verbal Cues', 0, 2, 1),
(28, 'Active Listening Techniques', 0, 1, 1),
(28, 'Giving and Receiving Constructive Feedback', 0, 2, 1),
(29, 'Communication in Difficult Conversations', 0, 1, 1),
(29, 'Cross-Cultural Communication', 0, 2, 1),
(30, 'What is True Productivity?', 1, 1, 1),
(30, 'Identifying Your Productivity Style', 0, 2, 1),
(31, 'Setting Meaningful Goals', 0, 1, 1),
(31, 'Prioritization Frameworks (Urgent/Important)', 0, 2, 1),
(32, 'Advanced Time Blocking', 0, 1, 1),
(32, 'Batching and Deep Work', 0, 2, 1),
(32, 'Reviewing Your Productivity', 0, 3, 1);

INSERT INTO LessonContent (LessonID, DocContent, VideoURL) VALUES
(1, 'Welcome to the Strategic Leadership course! In this lesson, we introduce the core objectives and structure of the entire course. Strategic leadership is a vital skill for modern leaders, combining vision, strategic thinking, and the ability to inspire teams. You will get a glimpse of how the course unfolds across chapters and understand how to navigate it. Leadership in today’s world demands agility, forward-thinking, and emotional intelligence. This lesson sets the foundation by emphasizing the importance of embracing change, developing clarity in communication, and identifying your leadership style. You’ll explore how strategic thinking differs from operational thinking and why it is essential to long-term success. The course will also include practical activities, case studies, and assessments to help reinforce learning. By the end of this lesson, you should be able to describe what strategic leadership means, identify the key characteristics of effective strategic leaders, and begin to self-assess your current skills. This first step is the beginning of a transformative journey where your leadership mindset and strategic capabilities will evolve significantly. We encourage you to take notes, participate in discussions, and reflect frequently as you progress. Remember, leadership is not about a title but about impact.',
'https://www.youtube.com/watch?v=sCQ0VYNCmKw'),

(2, 'Strategic thinking is the backbone of successful leadership. This lesson focuses on understanding why it matters so much. Strategic thinking allows leaders to align actions with a broader vision, anticipate changes, and make informed decisions. It’s about looking beyond the immediate and considering long-term implications. In this session, you’ll explore how strategic leaders differ from operational managers. Strategic thinkers consider market trends, internal capacities, and stakeholder needs all at once. You will examine real-life case studies where companies either succeeded or failed based on their strategic decisions. Moreover, the lesson highlights how to overcome common barriers to strategic thinking, such as tunnel vision or short-term focus. Tools like SWOT analysis, PESTLE framework, and scenario planning will be briefly introduced. You’ll be prompted to reflect on your own strategic awareness and think about recent decisions you made. Were they tactical or strategic? By the end, you’ll be more aware of how your thought process aligns with strategic goals and be better equipped to lead initiatives with a long-term impact.',
'https://www.youtube.com/watch?v=sCQ0VYNCmKw'),

(3, 'This lesson breaks down the fundamental principles and concepts behind strategic leadership. You will learn about vision setting, aligning teams, and making decisions under uncertainty. Strategic leadership requires a deep understanding of both internal and external environments. We’ll dive into the difference between reactive and proactive leadership, and explore models like the Balanced Scorecard and Strategic Alignment Model. You’ll also be introduced to the idea of competitive advantage and how a strategic leader ensures sustainability through innovation and culture. The lesson will guide you to assess your leadership behaviors and how they align with the organization’s mission and vision. You’ll engage in a self-reflection task where you map out your current leadership traits against strategic demands. We also touch on the importance of feedback, adaptability, and stakeholder management in achieving strategic goals. By applying these insights, you’ll begin building a personal roadmap for growth as a strategic leader.',
'https://www.youtube.com/watch?v=sCQ0VYNCmKw'),

(4, 'A compelling vision is the heart of any successful strategy. In this lesson, you’ll learn how to craft a vision that motivates and guides your team. A strong vision gives purpose and direction, especially during uncertainty. We’ll examine how great leaders communicate vision clearly and consistently, and how they engage others in co-creating it. You’ll review vision statements from top organizations and analyze what makes them effective. The lesson walks you through steps for crafting your own leadership vision: understanding your values, defining future goals, and articulating the why. You’ll practice creating a draft vision statement and receive criteria for refinement. A good vision is both inspiring and actionable—it should help people connect emotionally and understand where the organization is headed. You’ll also learn techniques for aligning your team’s daily actions with the broader vision. By the end of the lesson, you’ll have a stronger grasp of how a vision empowers leadership, drives alignment, and sustains focus.',
'https://www.youtube.com/watch?v=sCQ0VYNCmKw'),

(5, 'Setting strategic goals ensures your vision turns into action. This lesson teaches you how to define clear, measurable, and achievable goals. You’ll explore frameworks like SMART goals and OKRs (Objectives and Key Results). We’ll discuss how to differentiate between strategic, tactical, and operational goals. Real examples from businesses will illustrate how effective goal setting can transform an organization’s direction and culture. You’ll be asked to create your own strategic goals aligned with your vision and apply the SMART criteria. There will be exercises on identifying key performance indicators (KPIs) that track progress. You’ll also explore the role of cascading goals—how leadership goals should translate into team and individual objectives. This lesson emphasizes the importance of goal communication and alignment. A strategic goal without execution is merely a dream. By the end, you’ll have a practical goal-setting toolkit that aligns with your strategic direction and empowers teams to act with purpose.',
'https://example.com/videos/lesson5.mp4'),

(6, 'SWOT analysis is a foundational tool for strategic planning. This lesson explores how leaders can leverage SWOT (Strengths, Weaknesses, Opportunities, Threats) to make better decisions. You’ll learn how to conduct a SWOT analysis for your team, department, or project. Through real-world examples, we’ll show how this tool can uncover blind spots and illuminate areas for growth. We’ll provide a worksheet you can use to analyze your current situation and create action plans based on your findings. You’ll also explore how to prioritize issues identified in SWOT and how to integrate results into strategic goal setting. This lesson discusses common mistakes like being too vague or failing to act on insights. Strategic leaders use SWOT to continuously adapt and stay competitive. By the end, you’ll have completed your own SWOT analysis and identified at least two strategic initiatives based on your findings. This activity sets the foundation for your leadership planning going forward.',
'https://example.com/videos/lesson6.mp4'),

(7, 'Strategic initiatives are where strategy meets action. In this lesson, you’ll learn how to translate ideas into clear, manageable projects. Strategic initiatives are the vehicles through which visions and goals are realized. You’ll discover how to scope initiatives, assign responsibilities, and define success metrics. We’ll explore the role of project charters and how to build stakeholder buy-in early. You’ll be introduced to prioritization tools like the Eisenhower Matrix and Impact-Effort Grid to help decide which initiatives to start. The lesson includes guidance on breaking initiatives into phases, tracking progress, and ensuring accountability. Common pitfalls, such as lack of ownership or overcommitment, will also be discussed. You’ll practice mapping out a real initiative from your context, identifying key milestones and resources required. By the end, you’ll be equipped with a practical framework for leading successful strategic initiatives that drive real results.',
'https://example.com/videos/lesson7.mp4'),

(8, 'Team alignment is critical to executing strategy. This lesson helps you understand how to align team members with organizational goals and values. You’ll learn how communication, shared purpose, and role clarity contribute to alignment. Case studies will show how successful leaders foster alignment through regular check-ins, feedback loops, and collaborative planning. You’ll explore tools like team charters, scorecards, and strategic narratives. The lesson highlights the importance of onboarding and continuous reinforcement of strategic goals. You’ll also learn how to manage resistance and increase engagement. We’ll include a team alignment diagnostic tool that you can apply to your own team. By the end of this lesson, you’ll be better prepared to foster alignment, improve team cohesion, and enhance execution.',
'https://example.com/videos/lesson8.mp4'),

(9, 'Monitoring and evaluation ensure your strategies are working. In this lesson, you’ll learn how to set up effective tracking systems. Strategic leaders use dashboards, KPIs, and review cycles to monitor progress. You’ll explore how to define success indicators and collect feedback. The lesson includes tips on how to run effective review meetings, interpret results, and make adjustments. We’ll also touch on risk management—how to anticipate obstacles and develop contingency plans. Examples will demonstrate how timely evaluations helped organizations pivot and improve outcomes. You’ll be encouraged to create your own monitoring plan using the tools provided. By the end, you’ll understand how evaluation strengthens accountability and drives continuous improvement.',
'https://example.com/videos/lesson9.mp4'),

(10, 'Change is constant, and leaders must adapt quickly. This lesson focuses on how strategic leaders navigate change with confidence. You’ll explore the psychology of change and how it affects individuals and teams. The lesson introduces frameworks like Kotter’s 8-Step Change Model and Lewin’s Change Management theory. You’ll learn how to build change readiness, communicate transparently, and handle resistance. Case studies will show how poor change management leads to failure, while proactive leadership creates opportunities. You’ll practice developing a basic change management plan for a scenario in your workplace. By the end of this session, you’ll have tools to lead through uncertainty, inspire trust, and keep teams aligned—even in turbulent environments.',
'https://example.com/videos/lesson10.mp4'),

(11, 'Welcome to Time Management! This lesson introduces the importance of managing your time effectively to achieve both personal and professional goals. You’ll learn how time management is not just about being busy but about being productive. The lesson outlines common myths about multitasking and explains how prioritization can lead to significant improvements in efficiency. You will explore how leaders use time intentionally, and how poor time habits affect leadership performance. We’ll also guide you in conducting a quick time audit to assess how you currently spend your day. Effective time managers are not born; they build systems and habits that support their goals. This lesson serves as the gateway to understanding how to take control of your schedule, make time for strategic thinking, and reduce stress. By the end, you will reflect on how you value time, and why managing it well is one of the most powerful skills a leader can master.',
'https://example.com/videos/lesson11.mp4'),

(12, 'In this lesson, we help you identify the time wasters that silently drain your productivity. These could be unnecessary meetings, social media distractions, email overload, or unclear priorities. You’ll learn how to spot these habits, quantify their cost, and create strategies to reduce or eliminate them. A key activity includes analyzing your past week to determine where time went off track. The lesson also introduces the concept of “time leaks”—small, seemingly harmless activities that accumulate into hours of lost productivity. Leaders must protect their time fiercely, and that starts with awareness. We’ll share stories from professionals who reclaimed 5–10 hours per week by fixing time-wasting habits. You’ll come away from this lesson with a clearer understanding of what’s truly urgent versus what’s just noise.',
'https://example.com/videos/lesson12.mp4'),

(13, 'Prioritization is one of the most valuable leadership skills. In this lesson, you’ll learn how to rank tasks based on urgency and importance. You’ll work with models like the Eisenhower Matrix and ABCDE method to categorize your work effectively. We’ll walk you through examples of leaders who successfully turned chaos into focus using these frameworks. You’ll also explore how emotion and bias can impact our prioritization decisions. The lesson includes a prioritization exercise where you’ll sort your current responsibilities into focus categories. Leaders must learn when to say no, and when to delegate. By the end, you’ll feel more confident in your ability to protect time for high-impact activities.',
'https://example.com/videos/lesson13.mp4'),

(14, 'SMART goals are the foundation of effective planning. In this lesson, you’ll learn how to write goals that are Specific, Measurable, Achievable, Relevant, and Time-bound. We’ll review real-world examples of good and bad goals, and how clarity boosts motivation. You’ll also explore the connection between personal goals and organizational objectives. The lesson walks you through turning vague intentions into actionable commitments. You’ll write at least one SMART goal and outline the next three steps toward achieving it. By mastering SMART goal-setting, you’ll take control of your progress and be able to support others in doing the same.',
'https://example.com/videos/lesson14.mp4'),

(15, 'Time blocking is a productivity technique where you schedule every part of your day into designated blocks. In this lesson, you’ll learn how to implement time blocking to reduce context switching and increase deep work. We’ll also explore daily routines of high-performing leaders who block time for strategic thinking, team interaction, and self-care. You’ll be guided to create your own ideal day using time blocks and identify your peak productivity hours. This lesson encourages experimenting with various templates (e.g., maker schedule vs. manager schedule). By using this technique consistently, you’ll begin to feel more control over your time and attention.',
'https://example.com/videos/lesson15.mp4'),

(16, 'The Pomodoro Technique is a time management method that uses short bursts of focused work followed by short breaks. In this lesson, you’ll learn the origins of the method, how it works, and how to apply it using simple tools like a timer. You’ll explore the science behind why working in intervals improves focus and reduces mental fatigue. The lesson also discusses modifications to fit different personality types or work styles. We’ll walk you through your first Pomodoro session and give tips for staying disciplined. You’ll also learn how to track progress using completed Pomodoro sets. This method is especially helpful for tackling overwhelming tasks or overcoming procrastination.',
'https://example.com/videos/lesson16.mp4'),

(17, 'To-do lists are only effective if they’re structured well. This lesson teaches you how to design actionable and realistic to-do lists. We’ll explore common mistakes like overly long lists, vague tasks, and lack of prioritization. You’ll discover list formats like daily 3-task rules, MITs (Most Important Tasks), and time-estimated lists. The lesson includes a reflection activity where you analyze your current list-making habits and redesign them for clarity. We’ll also discuss analog vs. digital tools and introduce helpful apps. By the end, you’ll be able to create lists that boost clarity and actually move you forward.',
'https://example.com/videos/lesson17.mp4'),

(18, 'Distractions are everywhere—and they destroy focus. This lesson helps you identify internal and external distractions, and how to guard your attention. You’ll explore the role of environment, digital tools, and self-discipline. Common culprits like notifications, open tabs, or even background noise will be addressed. We’ll introduce the concept of attention residue—how switching tasks makes you less effective. You’ll be guided to set up a distraction-free zone and use techniques like batching and schedule anchoring. Distraction management is a cornerstone of sustained productivity, and this lesson will empower you to take back control.',
'https://example.com/videos/lesson18.mp4'),

(19, 'Procrastination is more about emotion than laziness. In this lesson, you’ll learn what causes procrastination—from fear of failure to perfectionism—and how to overcome it. We’ll explore science-backed methods like the 5-Minute Rule, temptation bundling, and cognitive reframing. You’ll reflect on tasks you’ve avoided recently and apply the techniques directly. We’ll also discuss how to build momentum with small wins and accountability. By the end, you’ll have a personalized anti-procrastination plan to implement immediately.',
'https://example.com/videos/lesson19.mp4'),

(20, 'Delegation is a leadership multiplier. This lesson explores why leaders struggle to delegate and how it can unlock time, trust, and talent. You’ll learn what tasks are best delegated, how to choose the right person, and how to communicate expectations clearly. We’ll walk through the 5 levels of delegation and how to empower rather than micromanage. Exercises include identifying tasks you can delegate this week and writing a delegation checklist. We’ll also share common delegation traps, such as reverse delegation or over-control. By the end, you’ll be equipped to grow your team’s ownership and your strategic focus.',
'https://example.com/videos/lesson20.mp4'),

(21, 'Brainstorming is a vital technique used to generate a wide range of ideas quickly and creatively. Whether working individually or in a group, it encourages free thinking, the suspension of judgment, and the exploration of diverse solutions. In a typical brainstorming session, participants contribute as many ideas as possible, even if they seem unrealistic at first. The focus is on quantity over quality to spark innovation and uncover hidden perspectives. Tools such as mind maps, sticky notes, and digital whiteboards can enhance the process. Effective facilitation ensures everyone’s voice is heard, and ideas are captured without criticism. Once the brainstorming session concludes, ideas are grouped, refined, and evaluated based on feasibility and relevance. Brainstorming can be applied to problem-solving, marketing, planning, and team building. It also fosters collaboration and helps break mental blocks by encouraging lateral thinking. As such, it remains a staple in both education and industry.',
'video21.mp4'),

(22, 'Action planning is the process of turning goals into concrete steps. It involves identifying specific actions, assigning responsibilities, setting deadlines, and allocating resources. An effective action plan breaks down large objectives into manageable tasks and helps ensure accountability. It also helps in tracking progress and making adjustments as needed. Without an action plan, even the best strategies can falter due to lack of direction. A good action plan includes what needs to be done, who will do it, when it will be completed, and how success will be measured. Regular check-ins and updates are important to keep everyone aligned and motivated. In team environments, action planning promotes transparency and collaboration. When challenges arise, a solid plan provides a framework to adapt and pivot efficiently. In summary, action planning brings structure and clarity to execution, making success more achievable.',
'video22.mp4'),

(23, 'Critical thinking is the ability to evaluate information logically and objectively. It allows individuals to make reasoned judgments by analyzing facts, identifying assumptions, and questioning evidence. In today’s fast-paced world, where misinformation can spread quickly, critical thinking is essential for making informed decisions. This skill involves being curious, open-minded, and reflective. Rather than accepting things at face value, critical thinkers seek deeper understanding and challenge their own viewpoints. They also differentiate between opinions and evidence, recognize bias, and understand the implications of their conclusions. In the workplace, critical thinking contributes to problem-solving, innovation, and effective communication. In academic settings, it enhances comprehension and learning. Cultivating this skill requires consistent practice, self-awareness, and a willingness to engage in difficult discussions. Ultimately, critical thinkers are better equipped to navigate complexity and uncertainty.',
'video23.mp4'),

(24, 'Understanding the structure of arguments and premises is essential for sound reasoning. An argument is a set of statements that support a conclusion, and the supporting statements are called premises. Being able to identify these parts allows individuals to evaluate the logic and strength of an argument. For example, if the premises are weak or irrelevant, the conclusion may not be valid. Recognizing logical fallacies—like false dilemmas, slippery slopes, or ad hominem attacks—is also a crucial part of argument analysis. Learning to map arguments visually can help clarify their structure and highlight weaknesses. This skill is particularly useful in debates, academic writing, legal reasoning, and professional communication. Mastery of argument identification improves critical thinking, persuasive abilities, and decision-making.',
'video24.mp4'),

(25, 'Cognitive biases are subconscious errors in thinking that affect judgment and decision-making. These biases often arise from the brain’s attempt to simplify information processing. While they can be useful in making quick decisions, they also lead to systematic errors. Common biases include confirmation bias (favoring information that confirms existing beliefs), anchoring bias (relying too heavily on the first piece of information), and availability bias (judging based on what comes easily to mind). Being aware of these biases is the first step toward reducing their impact. Strategies like seeking opposing viewpoints, slowing down decision-making, and using checklists can help mitigate bias. In professional environments, unchecked biases can lead to poor hiring, flawed strategies, and conflict. Developing awareness and applying objective methods fosters more rational and equitable thinking.',
'video25.mp4'),

(26, 'The communication process describes how information flows between a sender and a receiver. It includes components such as the message, encoding, channel, decoding, feedback, and potential noise. Effective communication occurs when the receiver interprets the message as the sender intended. However, barriers like language differences, distractions, or emotional interference can distort meaning. Understanding this process helps individuals tailor their communication style, choose the right channels, and confirm mutual understanding. Feedback is especially important as it closes the loop, confirming that the message has been received accurately. In the workplace, mastering the communication process improves collaboration, reduces errors, and enhances relationships. Whether it’s face-to-face, written, or digital, every form of communication benefits from clarity, empathy, and intention.',
'video26.mp4'),

(27, 'Verbal communication involves the use of words to convey information, whether spoken or written. It is the most direct and widely used form of communication. Effective verbal communication depends on clarity, tone, pace, and the appropriateness of language. In presentations or meetings, verbal skills influence how ideas are received and how persuasive the speaker is. Good communicators also consider their audience, avoiding jargon and adjusting their delivery based on context. Listening is a critical counterpart—understanding others helps foster meaningful dialogue. Developing verbal communication includes practicing active listening, improving vocabulary, and receiving feedback. In leadership, strong verbal skills enhance trust and motivation. In customer service, they build rapport and resolve issues. Ultimately, mastering verbal communication empowers individuals to express themselves confidently and respectfully.',
'video27.mp4'),

(28, 'Active listening is a communication technique that involves giving full attention to the speaker and responding thoughtfully. Unlike passive hearing, active listening requires mental engagement and non-verbal cues such as eye contact, nodding, and open body language. It also includes verbal affirmations, paraphrasing, and asking clarifying questions. Active listening builds trust, reduces misunderstandings, and strengthens relationships. It is especially useful in conflict resolution, counseling, and leadership. Barriers like distractions, assumptions, or emotional reactions can hinder listening. Practicing mindfulness and patience can improve one’s ability to stay present and focused. Active listeners not only absorb information more effectively but also make others feel heard and respected. This makes it a critical skill for both personal and professional growth.',
'video28.mp4'),

(29, 'Difficult conversations are a normal part of human interaction, especially in leadership and team environments. These include addressing poor performance, delivering negative feedback, or handling disagreements. The key to success lies in preparation, emotional control, and clear communication. Starting with empathy and focusing on shared goals helps reduce defensiveness. It’s important to use “I” statements, avoid blame, and give the other person time to respond. Active listening is crucial—acknowledging feelings and perspectives can de-escalate tension. Timing and setting also matter; private, neutral spaces are best for sensitive topics. Practicing these conversations beforehand can build confidence. When handled skillfully, difficult conversations lead to stronger relationships, greater trust, and improved outcomes. Avoiding them, on the other hand, can create confusion and resentment.',
'video29.mp4'),

(30, 'True productivity isn’t about doing more—it’s about doing what matters most, effectively. It involves setting meaningful goals, focusing on priorities, and managing time and energy wisely. Productivity varies by person, so understanding your own work style is essential. Some thrive with strict schedules, while others need flexibility. Techniques like time blocking, task batching, and the Pomodoro method help structure work. Equally important is minimizing distractions—turning off notifications, setting boundaries, and creating a focused workspace. Being productive also means saying no to tasks that don’t align with your goals. Reflecting on your daily output and adjusting habits improves efficiency over time. Ultimately, true productivity results in progress with purpose—not just being busy but being effective. This leads to better performance, greater satisfaction, and less burnout.',
'video30.mp4'),

(31, 'Setting meaningful goals is the foundation of personal and professional success. Unlike vague aspirations, meaningful goals are specific, purposeful, and aligned with one’s values and priorities. These goals provide motivation and a clear sense of direction. Using frameworks like SMART (Specific, Measurable, Achievable, Relevant, Time-bound) helps ensure goals are well-defined and achievable. Setting goals also promotes accountability—by defining desired outcomes, individuals are more likely to stay focused and persist through challenges. It is helpful to break long-term goals into smaller milestones and regularly track progress. Reflection and adjustment are also important, as circumstances and priorities can change. When individuals pursue goals that resonate with their deeper aspirations, they experience greater satisfaction and fulfillment. Whether personal, academic, or career-oriented, meaningful goal-setting empowers individuals to take control of their lives and achieve purposeful success.',
'video31.mp4'),

(32, 'Advanced time blocking is a powerful strategy for managing time, energy, and focus. Unlike simple to-do lists, time blocking involves scheduling specific tasks during set time periods throughout the day. This method helps reduce multitasking and context switching, both of which hinder productivity. With advanced time blocking, individuals also assign themes to certain blocks (e.g., “creative work,” “email,” “meetings”) to group similar tasks and streamline mental focus. It’s important to leave buffer time between blocks to handle unexpected tasks or breaks. Weekly reviews can help you identify where time was wasted and adjust future plans. Digital tools like Google Calendar or Notion, and analog planners alike, support this system. Ultimately, time blocking gives structure to your day, aligns daily actions with long-term goals, and fosters deep, focused work. It’s particularly effective for professionals managing complex projects or balancing multiple responsibilities.',
'video32.mp4'),

(33, 'Batching and deep work are two productivity techniques designed to help individuals focus better and produce higher-quality results. Batching involves grouping similar tasks and completing them together to reduce mental load. For example, answering emails at designated times rather than constantly checking your inbox. Deep work, on the other hand, refers to focused, uninterrupted work on cognitively demanding tasks. This requires eliminating distractions and working in extended time blocks. To achieve deep work, you may need to turn off notifications, use website blockers, or create a dedicated workspace. Both batching and deep work help improve efficiency and output by leveraging your brain’s natural focus rhythms. They are especially beneficial for writers, programmers, designers, and others in creative or analytical fields. Practicing these techniques consistently can dramatically improve productivity, reduce stress, and lead to more meaningful work outcomes.',
'video33.mp4'),

(34, 'Reviewing your productivity is a critical step in continual improvement. It allows you to evaluate how effectively you’ve used your time and whether your efforts aligned with your goals. Weekly or daily reviews help identify what worked well, what didn’t, and what can be improved. This process can include checking off completed tasks, reflecting on challenges, and analyzing how distractions affected focus. It’s also a time to celebrate wins and revise your approach for the upcoming period. Tools like journaling, productivity apps, or simple spreadsheets can support this habit. Regular reviews foster greater self-awareness and discipline. Over time, they help individuals refine their systems, eliminate inefficiencies, and stay motivated. Ultimately, productivity reviews are not just about measuring output but ensuring that your work is intentional and impactful.',
'video34.mp4'),

(35, 'Motivating and inspiring your team is one of the most important leadership responsibilities. Motivation is not just about financial incentives—it involves creating a sense of purpose, belonging, and recognition. Great leaders connect daily work to larger organizational goals, making employees feel their contributions matter. They also empower team members by providing autonomy, offering growth opportunities, and acknowledging accomplishments. Inspiration, on the other hand, comes from the leader’s own passion, vision, and authenticity. When leaders model resilience, positivity, and strong values, it encourages others to do the same. Open communication, trust, and empathy are key to building a motivated team culture. By investing in people, listening to their ideas, and supporting their development, leaders cultivate loyalty and high performance. Ultimately, a motivated team is more productive, engaged, and innovative.',
'video35.mp4'),

(36, 'Conflict resolution is a vital skill in any team environment. Differences in perspectives, communication styles, or goals can lead to tension and disagreements. However, when managed constructively, conflict can lead to better ideas and stronger relationships. The first step is identifying the root cause and ensuring that all parties feel heard. Active listening, empathy, and remaining calm are essential during conflict discussions. Solutions should focus on common goals and mutual benefit. Techniques like mediation, using “I” statements, and setting ground rules can facilitate productive dialogue. Leaders play a key role by modeling respectful behavior, addressing issues early, and fostering a safe environment for open communication. Avoiding conflict, on the other hand, often leads to unresolved tension and decreased team morale. Embracing conflict as an opportunity for growth leads to healthier, more collaborative teams.',
'video36.mp4'),

(37, 'Leading through change requires adaptability, clear communication, and empathy. In a constantly evolving business environment, change is inevitable—whether due to market shifts, organizational restructuring, or technological advancements. Leaders must help their teams navigate uncertainty and remain focused. This involves explaining the reasons for change, setting expectations, and providing support throughout the transition. Transparency is crucial—people are more willing to embrace change when they understand its purpose. Empathetic leadership also acknowledges the emotional responses to change and provides space for feedback and concerns. By involving team members in the change process, leaders build trust and increase buy-in. Successful change leadership includes celebrating small wins, monitoring progress, and staying flexible. Ultimately, leaders who guide others through change with vision and compassion create resilient, future-ready teams.',
'video37.mp4'),

(38, 'Resilience in leadership is the capacity to recover from setbacks, stay optimistic in the face of adversity, and adapt to challenges. Resilient leaders maintain perspective, regulate their emotions, and remain solution-focused even under pressure. This mindset not only helps them cope personally but also sets the tone for their teams. Building resilience involves developing emotional intelligence, practicing self-care, and cultivating a strong support network. Leaders should also encourage open dialogue, create psychological safety, and normalize learning from failure. Resilient organizations are built by resilient leaders who foster a growth mindset and continuous improvement. In a volatile and unpredictable world, resilience is more than just endurance—it’s about evolving, innovating, and thriving through change.',
'video38.mp4'),

(39, 'Emotional intelligence (EQ) is the ability to recognize, understand, and manage your emotions and those of others. It plays a key role in leadership, teamwork, and interpersonal relationships. Leaders with high EQ communicate more effectively, resolve conflicts with empathy, and build stronger connections with their teams. The five core components of EQ are self-awareness, self-regulation, motivation, empathy, and social skills. Developing EQ requires reflection, feedback, and practice. For example, journaling can enhance self-awareness, while mindfulness supports emotional regulation. EQ also involves active listening and recognizing non-verbal cues in others. In today’s collaborative work environments, technical skills alone are not enough—emotional intelligence is a critical differentiator for effective leadership and personal growth.',
'video39.mp4'),

(40, 'Understanding the workplace importance of emotional intelligence (EQ) helps employees and leaders alike foster stronger collaboration and a positive culture. EQ enhances communication, builds trust, and minimizes conflict. In high-pressure settings, individuals with strong EQ can remain calm, empathetic, and constructive. Teams led by emotionally intelligent leaders tend to be more cohesive and engaged. Developing EQ in the workplace can include training, coaching, and feedback. It also involves modeling behavior such as giving recognition, showing appreciation, and managing stress effectively. EQ is especially important in customer-facing roles, where empathy and clarity affect client satisfaction. As work environments become more diverse and complex, emotional intelligence will continue to be a critical asset for success.',
'video40.mp4'),

(41, 
'Effective communication is a critical skill for any leader. It involves not just conveying a message, but ensuring that the message is understood and acted upon in the way it was intended. Good communication starts with clarity—leaders must be able to express ideas, goals, and feedback in a manner that is easy to understand. This requires not only a strong command of language, but also empathy, active listening, and non-verbal awareness. Leaders must tailor their communication styles depending on the audience and the context. For example, delivering performance feedback requires a different tone and approach than sharing a company vision. Moreover, communication in leadership is not one-way—it requires building open channels where team members feel safe to share ideas, raise concerns, and contribute to decision-making. Utilizing storytelling can also enhance communication by making messages more memorable and emotionally impactful. Effective leaders regularly check for understanding, encourage dialogue, and are receptive to feedback themselves. As organizations grow in complexity, communication becomes even more vital to ensure alignment, motivation, and collaboration across teams. Leaders who excel in communication often build stronger trust, foster better working environments, and drive superior results.', 
'https://www.example.com/video41'),

(42, 
'Decision-making is a core responsibility of any leader. It involves selecting the best course of action among multiple alternatives and often requires balancing risk, time constraints, and available information. Good decision-makers do not rely solely on intuition; they gather and analyze data, consult with stakeholders, and anticipate potential outcomes. The most effective leaders also consider the long-term impact of their decisions on people, processes, and organizational goals. Decision-making styles vary: some leaders are more democratic and seek input from their teams, while others may take a more autocratic or data-driven approach depending on the situation. Regardless of style, transparency in the decision-making process builds credibility and trust. Leaders should also be willing to revisit and revise decisions when new information emerges. Learning from past decisions, both good and bad, is critical to continuous improvement. Creating a culture where it’s safe to make mistakes and learn from them encourages innovation and growth. Tools like decision matrices, SWOT analysis, and scenario planning can support structured decision-making. Ultimately, leaders must take accountability for their choices and remain committed to seeing them through.', 
'https://www.example.com/video42'),

(43, 
'Delegation and empowerment are essential skills for effective leadership. Delegation involves assigning tasks and responsibilities to others, freeing the leader to focus on strategic initiatives. However, effective delegation goes beyond merely passing on work—it requires matching the right tasks to the right people based on their strengths, experience, and development goals. Empowerment, on the other hand, means giving team members the authority, resources, and confidence to make decisions and take ownership of their work. Empowered employees are more engaged, motivated, and productive because they feel trusted and valued. Leaders must provide clear expectations, support, and feedback while avoiding micromanagement. Regular check-ins help ensure progress and offer opportunities for coaching without undermining autonomy. Empowering others also fosters innovation, as people are more likely to share ideas and take initiative when they feel their contributions matter. Leaders who master delegation and empowerment build stronger, more capable teams that can operate effectively even in the leader’s absence.', 
'https://www.example.com/video43'),

(44, 
'Motivating and inspiring teams is a core function of leadership. A motivated team is one that is committed to organizational goals, works collaboratively, and demonstrates resilience in the face of challenges. Motivation can be intrinsic, such as finding meaning and satisfaction in the work itself, or extrinsic, like financial rewards and recognition. Effective leaders understand what drives their team members and tailor their approach accordingly. They articulate a compelling vision, recognize contributions, provide growth opportunities, and foster a culture of trust and transparency. Inspiration, however, goes beyond motivation. Inspiring leaders lead by example, communicate passionately, and connect emotionally with their teams. They challenge the status quo and encourage others to reach their full potential. Creating a sense of purpose and belonging helps teams feel aligned and energized. Recognizing small wins, celebrating progress, and showing genuine appreciation are simple yet powerful ways to keep morale high. In short, leaders who consistently motivate and inspire unlock the full potential of their teams.', 
'https://www.example.com/video44'),

(45, 
'Conflict resolution is a necessary leadership skill in any team environment. Conflict is inevitable when individuals with diverse perspectives, experiences, and communication styles work together. However, not all conflict is negative—when managed well, it can lead to creative solutions, improved relationships, and stronger teams. The key is addressing issues early before they escalate. Leaders should create a safe environment where concerns can be raised respectfully. Active listening, empathy, and neutrality are essential during conflict resolution. It’s important to separate the problem from the people, focus on interests rather than positions, and seek win-win outcomes. Conflict styles such as avoiding, accommodating, competing, compromising, and collaborating each have their place depending on the context. Leaders should model constructive conflict behavior and train their teams in conflict management techniques. By promoting open communication, setting clear expectations, and encouraging mutual respect, leaders can transform conflict into an opportunity for growth and innovation.', 
'https://www.example.com/video45'),

(46, 
'Leading through change is one of the most challenging yet vital responsibilities of a leader. In today’s fast-paced business environment, organizations must continuously adapt to evolving markets, technologies, and customer needs. Change can create uncertainty and resistance among employees, making leadership support critical. Effective change leaders communicate the rationale behind change clearly, involve key stakeholders in planning, and provide consistent updates throughout the transition. They anticipate and address resistance by empathizing with concerns, offering support, and involving employees in shaping the change process. It’s also important to maintain a clear vision, demonstrate commitment, and celebrate progress along the way. Change leadership requires resilience, flexibility, and the ability to inspire confidence even during difficult times. By being transparent and approachable, leaders build trust and help their teams embrace change as a path to opportunity and growth.', 
'https://www.example.com/video46'),

(47, 
'Resilience in leadership is the ability to maintain focus, energy, and a positive mindset in the face of adversity. Leaders often deal with high-pressure situations, unexpected setbacks, and complex decisions. Resilient leaders do not allow failures to define them; instead, they view challenges as learning opportunities. Building resilience involves emotional regulation, optimism, adaptability, and strong social support systems. Leaders can develop these traits through mindfulness, reflection, physical well-being, and time management. Supporting others resilience is also key—leaders must create environments where employees feel psychologically safe, supported, and encouraged to take calculated risks. They role-model composure, perseverance, and accountability, which inspires others to do the same. During crises, resilient leaders provide calm, clarity, and direction. They communicate honestly, offer hope, and lead with empathy. Resilience not only enhances individual well-being but also contributes to long-term organizational success and sustainability.', 
'https://www.example.com/video47'),

(48, 
'Emotional Intelligence (EQ) is the ability to recognize, understand, manage, and influence emotions in oneself and others. It is widely considered a vital leadership trait that impacts communication, decision-making, team dynamics, and conflict resolution. EQ consists of five core components: self-awareness, self-regulation, motivation, empathy, and social skills. Self-aware leaders understand their emotions and how they affect others. Self-regulation allows them to control impulses and respond constructively. Motivation drives them to pursue goals with passion and persistence. Empathy helps leaders connect with others on a deeper level, fostering trust and inclusion. Lastly, social skills enable effective communication, collaboration, and influence. Leaders with high EQ build stronger relationships, resolve conflicts more effectively, and create positive workplace cultures. Unlike IQ, EQ can be developed through practice, feedback, and reflection. Training programs, coaching, and mindfulness are useful tools to enhance emotional intelligence over time.', 
'https://www.example.com/video48'),

(49, 
'Emotional Intelligence (EQ) plays a crucial role in the modern workplace. It affects how individuals interact with colleagues, manage stress, and perform under pressure. Leaders with high EQ create inclusive and psychologically safe environments where people feel heard, respected, and valued. This, in turn, enhances engagement, collaboration, and performance. EQ also supports ethical decision-making and reduces burnout by encouraging empathy and balance. Organizations that prioritize EQ in hiring, training, and culture development tend to have lower turnover rates and higher employee satisfaction. From navigating team dynamics to handling customer complaints, EQ enables professionals to respond thoughtfully rather than react impulsively. In conflict situations, those with strong EQ can de-escalate tension and find constructive paths forward. Encouraging emotional intelligence at all levels promotes resilience, well-being, and a stronger organizational identity. As the business world becomes more complex, EQ will continue to be a key differentiator for leadership success.', 
'https://www.example.com/video49'),

(50, 
'Developing self-awareness at work is essential for personal growth and professional effectiveness. Self-awareness involves understanding your strengths, weaknesses, emotions, values, and impact on others. In the workplace, self-aware individuals are better able to manage stress, communicate effectively, and build positive relationships. They are more open to feedback and demonstrate higher levels of accountability. Leaders with self-awareness can recognize their leadership style, biases, and blind spots, allowing them to adjust their approach as needed. Tools like personality assessments, journaling, reflection exercises, and 360-degree feedback help individuals enhance their self-understanding. By regularly seeking input and observing one’s behavior in different situations, professionals can identify patterns and improve their responses. Self-awareness also contributes to emotional intelligence, decision-making, and leadership effectiveness. When teams are composed of self-aware members, collaboration improves, and conflicts are resolved more constructively. It is a foundational skill that supports lifelong learning and career advancement.', 
'https://www.example.com/video50'),

(51, 
'Self-regulation is the ability to control your emotions, thoughts, and behaviors in different situations. It is a vital component of emotional intelligence and directly impacts performance, relationships, and stress management. In the workplace, individuals who can self-regulate are more reliable, adaptable, and composed under pressure. They respond to challenges with thoughtfulness rather than impulsivity. Leaders who demonstrate self-regulation foster trust, as they remain calm and objective even during crises. Strategies for improving self-regulation include mindfulness, deep breathing, reframing negative thoughts, and maintaining a healthy work-life balance. Setting clear goals and tracking progress also supports better self-control. It’s important to recognize triggers that lead to stress or frustration and to develop healthy coping mechanisms. Organizations can support self-regulation by promoting well-being, offering flexible work options, and encouraging open dialogue. Ultimately, self-regulation empowers individuals to stay focused, make rational decisions, and contribute positively to team dynamics.', 
'https://www.example.com/video51'),

(52, 
'Practicing empathy in professional settings strengthens relationships, enhances communication, and improves teamwork. Empathy is the ability to understand and share the feelings of others. In a diverse workplace, empathy allows individuals to connect across differences in background, experience, and perspective. Empathetic leaders are better able to support their teams, resolve conflicts, and make inclusive decisions. Empathy involves active listening, asking thoughtful questions, and being present in conversations. It also means recognizing non-verbal cues and responding with compassion. Cultivating empathy starts with self-awareness and a willingness to see things from another person’s point of view. Creating a culture of empathy in the workplace leads to higher employee engagement, customer satisfaction, and innovation. Training programs, team-building exercises, and leadership modeling can all foster empathy at scale. In today’s interconnected world, empathy is not just a soft skill—it is a business imperative.', 
'https://www.example.com/video52'),

(53, 
'Building strong work relationships is crucial for a successful and fulfilling career. Positive relationships at work contribute to better collaboration, increased morale, and higher productivity. Trust, respect, and open communication form the foundation of strong professional bonds. Individuals should strive to be dependable, supportive, and respectful in all interactions. Active listening, empathy, and showing appreciation help strengthen connections. Conflict is natural, but how it is handled determines the health of a relationship. Addressing issues early, offering constructive feedback, and being willing to compromise are key to maintaining trust. Leaders play a pivotal role by setting the tone for respectful communication and team unity. Networking, mentoring, and team-building activities also foster meaningful relationships. In remote or hybrid work environments, intentional efforts such as virtual check-ins and collaboration tools help maintain connection. Strong work relationships not only improve job performance but also enhance job satisfaction and personal well-being.', 
'https://www.example.com/video53'),

(54, 
'Problem solving is a fundamental skill in both professional and personal life. It involves identifying challenges, analyzing root causes, and finding effective solutions. The problem-solving process typically includes defining the problem clearly, gathering information, brainstorming possible solutions, selecting the best option, and implementing it. Reflection and learning from the outcome are also essential. Strong problem solvers remain calm under pressure, approach challenges methodically, and are open to feedback. Tools like the 5 Whys, Fishbone Diagram, and SWOT analysis can aid in structuring the problem-solving process. In a team setting, involving multiple perspectives often leads to more innovative solutions. Leaders should encourage a problem-solving mindset by fostering psychological safety and supporting experimentation. Effective problem solving boosts efficiency, reduces risk, and drives continuous improvement. It’s a skill that becomes stronger with practice and experience.', 
'https://www.example.com/video54'),

(55, 
'Defining the problem clearly is the first and arguably most important step in the problem-solving process. Many efforts to fix an issue fail because the real problem was never accurately identified. A well-defined problem provides focus and direction for finding a solution. It involves asking the right questions, gathering facts, and distinguishing symptoms from root causes. A clear problem statement should be specific, measurable, and framed without assumptions. For example, instead of saying “Sales are down,” a clearer statement would be “Sales of product X declined by 15% in Q2 compared to Q1 in region Y.” By narrowing the scope, teams can target their analysis and solutions effectively. Visualization tools, data analysis, and stakeholder interviews help clarify complex issues. Leaders should guide their teams through this phase with patience and objectivity. A clear understanding of the problem lays the groundwork for innovation and successful outcomes.', 
'https://www.example.com/video55'),

(56,
'Root cause analysis (RCA) is a structured approach used to identify the fundamental reason a problem occurs. Unlike treating symptoms, RCA focuses on finding the origin of a problem to prevent recurrence. One popular method is the "5 Whys" technique, where you repeatedly ask "why" to each answer until you uncover the core issue. For example, if a product is delayed, asking why might lead you from missed deadlines to poor planning to lack of resource allocation. Other RCA tools include fishbone diagrams (Ishikawa), fault tree analysis, and Pareto analysis. The effectiveness of RCA depends on accurate data, cross-functional input, and a commitment to follow through on solutions. In organizations, RCA should be a regular part of problem-solving efforts—not just after major failures but also for ongoing process improvement. Leaders play a key role by fostering a culture that investigates issues without blame, encouraging transparency and continuous learning. Ultimately, solving root causes leads to greater efficiency, reduced costs, and higher customer satisfaction.',
'https://www.example.com/video56'),

(57,
'Brainstorming is a creative problem-solving technique that encourages the generation of multiple ideas before evaluating them. The goal is to unlock innovation by allowing participants to think freely, without immediate judgment or criticism. In a brainstorming session, it’s important to create a psychologically safe environment where all contributions are welcomed. Effective brainstorming includes clear problem definition, time-boxing, and a facilitator to guide the process. Variations such as brainwriting (writing ideas down before sharing), mind mapping, and SCAMPER technique (Substitute, Combine, Adapt, Modify, Put to another use, Eliminate, Reverse) add structure and variety to sessions. After ideas are generated, teams can evaluate them using criteria like feasibility, impact, and alignment with goals. Digital tools such as Miro or MURAL can support remote brainstorming. By encouraging diverse perspectives and deferring judgment, brainstorming can lead to breakthrough solutions and team engagement. It remains one of the most accessible and effective methods for generating creative options to business challenges.',
'https://www.example.com/video57'),

(58,
'Evaluating potential solutions is a critical step in the problem-solving process. After generating multiple ideas through brainstorming or analysis, it’s important to assess which solutions are most viable, effective, and aligned with strategic goals. Key criteria include feasibility (can it be implemented with current resources?), impact (will it solve the root problem?), cost, time, and stakeholder support. Tools such as decision matrices and cost-benefit analysis can help compare options objectively. Involving cross-functional stakeholders in the evaluation process ensures diverse perspectives and strengthens buy-in. Testing ideas on a small scale (e.g., through pilot programs or prototypes) before full implementation can reduce risk. Leaders must also consider potential unintended consequences and ensure the chosen solution aligns with organizational values and culture. Documenting the rationale for the chosen approach is essential for transparency and accountability. A structured, data-informed evaluation process not only improves decision quality but also boosts the success rate of implementation.',
'https://www.example.com/video58'),

(59,
'Action planning and implementation turn ideas into results. After selecting the best solution to a problem, a detailed action plan ensures that everyone knows what needs to be done, by whom, and by when. A strong plan includes specific tasks, assigned responsibilities, deadlines, required resources, and success metrics. Tools like Gantt charts, project management software, and RACI matrices (Responsible, Accountable, Consulted, Informed) help clarify roles and timelines. It’s also important to establish checkpoints for progress reviews, identify potential risks, and create contingency plans. Clear communication and documentation ensure that all stakeholders are aligned and informed. During implementation, leaders must monitor progress, address barriers quickly, and motivate team members. Celebrating small wins can maintain momentum. Ultimately, a good plan is dynamic—it should evolve based on feedback and real-world conditions. With solid planning and execution, even the most ambitious solutions can lead to sustainable change and improvement.',
'https://www.example.com/video59'),

(60,
'Monitoring and adapting solutions is the final, but ongoing, phase of the problem-solving process. Even well-implemented solutions may need adjustments due to unforeseen challenges or changes in context. Continuous monitoring involves tracking key performance indicators (KPIs) that measure whether the solution is working as intended. This can include both quantitative data (like performance metrics or financial indicators) and qualitative feedback (such as employee or customer satisfaction). Leaders should set regular review intervals and create feedback loops that allow for quick course corrections. Flexibility is key—solutions should be adapted, scaled, or replaced as necessary based on results. Transparency in this phase fosters trust and ensures accountability. Organizations that embrace monitoring and learning tend to innovate faster and maintain a competitive edge. Documenting lessons learned also builds organizational knowledge and informs future initiatives. Adaptability is not a sign of failure, but a strength in dynamic environments where change is constant.',
'https://www.example.com/video60'),

(61,
'Critical thinking is the process of actively analyzing, evaluating, and synthesizing information to guide decision-making and problem-solving. It involves questioning assumptions, identifying biases, and considering multiple perspectives before arriving at conclusions. In the workplace, critical thinking helps professionals navigate complexity, avoid costly errors, and make well-reasoned choices. Unlike passive acceptance of information, critical thinking requires a healthy level of skepticism and curiosity. It encourages evidence-based reasoning and logical consistency. Leaders with strong critical thinking skills can evaluate data effectively, anticipate consequences, and adapt strategies as needed. Training in critical thinking often includes exercises in logic, argument evaluation, and case analysis. Cultivating this skill fosters innovation, improves collaboration, and enhances communication. In a rapidly changing world, critical thinking is essential not only for leaders but for every team member tasked with making decisions in uncertain or ambiguous environments.',
'https://www.example.com/video61'),

(62,
'Objective analysis is the practice of examining facts and evidence without allowing personal feelings, opinions, or biases to interfere. In decision-making, objective analysis ensures that choices are based on data and logic rather than intuition or pressure. Leaders must be able to distinguish between subjective impressions and measurable realities. This involves critical thinking, asking the right questions, and validating sources. Tools like statistical analysis, performance metrics, and data visualization aid in interpreting complex information. Being objective also means acknowledging uncertainty and being open to alternative viewpoints. It fosters fairness, credibility, and trust—especially in high-stakes or controversial decisions. In team settings, promoting objectivity can improve group decision-making and reduce conflict. Ultimately, objective analysis leads to better outcomes, higher accountability, and a culture of integrity. It also strengthens the organization’s ability to learn from mistakes and improve over time.',
'https://www.example.com/video62'),

(63,
'Identifying arguments and premises is a foundational critical thinking skill. An argument consists of one or more premises that support a conclusion. Understanding how arguments are structured helps individuals evaluate their strength and validity. For example, a valid argument must have logically connected premises and a conclusion that follows from them. In workplace scenarios, identifying arguments allows team members to engage in productive debate, spot faulty reasoning, and build stronger cases for action. Common mistakes include confusing correlation with causation, appealing to authority without evidence, or relying on emotional rhetoric. Practicing argument analysis involves listening actively, breaking down statements, and asking clarifying questions. This skill is particularly valuable in negotiations, strategic planning, and conflict resolution. Teaching teams to identify arguments improves collaboration and decision-making, ensuring that discussions are based on logic rather than assumptions. Over time, this leads to a more thoughtful, analytical culture where sound reasoning drives success.',
'https://www.example.com/video63'),

(64,
'Evaluating evidence and sources is essential in an age where misinformation spreads rapidly. Professionals must be able to assess the reliability, relevance, and credibility of data before using it to inform decisions. This involves checking the author’s credentials, publication date, supporting references, and potential biases. Primary sources are generally more trustworthy than secondary interpretations, and peer-reviewed materials carry more weight than opinion pieces. Evaluating evidence also means considering whether the information is consistent with other known facts and whether it logically supports a claim. In business, decisions based on poor data can lead to financial loss, legal issues, or reputational damage. Leaders should encourage a culture where team members question sources and verify information. Training in research literacy, critical reading, and fact-checking tools helps build this competency. Ultimately, high standards for evidence safeguard the quality of decision-making and strengthen organizational integrity.',
'https://www.example.com/video64'),

(65,
'Cognitive biases are mental shortcuts that can lead to flawed reasoning and poor decisions. These biases are natural—they help us process information quickly—but they often distort reality. Common biases include confirmation bias (favoring information that supports existing beliefs), availability bias (overestimating events that come easily to mind), and anchoring bias (relying too heavily on the first piece of information encountered). In leadership, being unaware of biases can result in unfair treatment, missed opportunities, or strategic errors. The first step in overcoming bias is awareness. Leaders can mitigate bias by seeking diverse perspectives, using structured decision-making processes, and encouraging debate. Tools like checklists, devil’s advocacy, and pre-mortems can help expose and correct cognitive blind spots. Training in bias recognition enhances objectivity and fairness, leading to better outcomes. Building awareness of biases across teams also strengthens organizational resilience and adaptability in a complex world.',
'https://www.example.com/video65'),

(66,
'Applying critical thinking to decision-making enhances clarity, reduces risk, and supports better outcomes. Instead of reacting impulsively, critical thinkers pause to gather information, consider alternatives, and evaluate potential consequences. They ask probing questions, seek evidence, and weigh trade-offs. This process improves the quality of both individual and group decisions. For example, when faced with a budget cut, a critical thinker might evaluate which programs deliver the most value rather than implementing across-the-board reductions. Leaders who model critical thinking foster a culture of thoughtful inquiry, where employees are encouraged to challenge assumptions and propose innovative solutions. Using frameworks like the decision tree, SWOT analysis, and cost-benefit analysis can structure thinking and reduce emotional influence. Over time, applying critical thinking builds confidence, enhances problem-solving capacity, and contributes to long-term success in dynamic environments.',
'https://www.example.com/video66'),

(67,
'The communication process involves the exchange of information between a sender and a receiver, aiming for mutual understanding. It consists of key elements: the message, the sender, the receiver, the medium (e.g., spoken, written), and feedback. Noise—such as distractions, misunderstandings, or language barriers—can interfere with this process. Effective communication requires clarity, active listening, and consideration of the audience’s perspective. In professional environments, communication skills impact every aspect of teamwork, leadership, and customer interaction. Non-verbal cues like tone, body language, and facial expressions also play an important role. Ensuring that feedback is incorporated confirms that the message was understood. Leaders should foster open communication channels and model transparency, empathy, and respect. By mastering the communication process, individuals and organizations build stronger relationships, increase efficiency, and reduce conflict. Training in communication skills can greatly enhance overall performance and workplace harmony.',
'https://www.example.com/video67'),

(68,
'Barriers to effective communication can significantly hinder understanding and collaboration in the workplace. These barriers may be physical (like noise or poor technology), psychological (such as stress or prejudice), semantic (confusing language or jargon), or cultural (differences in values or communication styles). Recognizing and addressing these barriers is essential for effective leadership and teamwork. Strategies include simplifying language, active listening, using visual aids, checking for understanding, and promoting a culture of openness. Leaders can reduce communication barriers by encouraging feedback, clarifying expectations, and fostering psychological safety. In diverse teams, cultural awareness and sensitivity training can improve mutual understanding. By proactively addressing communication challenges, organizations enhance clarity, reduce conflict, and increase productivity. Ultimately, strong communication is not only about speaking well but also about ensuring messages are received and understood as intended.',
'https://www.example.com/video68'),

(69,
'Verbal communication is the use of spoken language to convey meaning, ideas, and intentions. Mastering verbal communication requires clarity, tone, pace, and articulation. In a professional setting, how you say something often matters as much as what you say. Good verbal communicators are concise, persuasive, and attentive to their audience. They adjust their speech based on context—whether leading a meeting, resolving a conflict, or presenting to executives. Active listening is equally important—it shows respect, ensures mutual understanding, and builds rapport. Leaders should model strong verbal communication by being intentional, inclusive, and responsive. Training in public speaking, storytelling, and negotiation can strengthen this skill. Verbal communication also enhances collaboration, customer service, and team dynamics. In short, it is a foundational skill that supports nearly every aspect of professional success.',
'https://www.example.com/video69'),

(70,
'Non-verbal communication includes all forms of communication without spoken words—such as body language, facial expressions, posture, gestures, and eye contact. These cues often reveal more than verbal language and can either reinforce or contradict what’s being said. For example, crossed arms may signal defensiveness, while open posture conveys approachability. In professional settings, understanding and using non-verbal cues effectively is critical. Leaders who maintain eye contact, smile appropriately, and use confident gestures build trust and engagement. Misreading non-verbal signals can lead to misunderstanding or conflict, especially in multicultural environments where body language meanings vary. Being aware of your own non-verbal habits and reading others’ signals can greatly enhance communication. Training and practice can improve your ability to send and interpret non-verbal messages. Ultimately, mastering non-verbal communication leads to more authentic interactions and stronger relationships.',
'https://www.example.com/video70'),

(71,
'Active listening is a foundational communication skill that involves fully concentrating, understanding, responding, and remembering what the speaker says. Unlike passive hearing, active listening requires deliberate effort and attention. It includes verbal cues like summarizing or asking clarifying questions, and non-verbal cues such as nodding, eye contact, and open body language. Active listening helps build trust, resolve conflict, and ensure mutual understanding. In professional settings, it can lead to better teamwork, fewer misunderstandings, and stronger client relationships. Barriers to active listening include distractions, assumptions, multitasking, and internal bias. To practice active listening, individuals should minimize distractions, be patient, avoid interrupting, and mentally engage with the speaker’s message. Leaders who model active listening show respect, increase employee engagement, and create inclusive environments. This skill is especially vital during performance reviews, conflict resolution, and feedback conversations. When teams embrace active listening, collaboration improves and miscommunication decreases.',
'https://www.example.com/video71'),

(72,
'Constructive feedback is essential for personal growth, team development, and organizational improvement. Giving and receiving feedback effectively can enhance performance, motivation, and relationships. Constructive feedback focuses on behaviors and outcomes rather than personal attributes. It is specific, timely, and framed in a way that encourages improvement. Using the "SBI" model (Situation-Behavior-Impact) helps provide clear and actionable input. For example: “In yesterday’s meeting (Situation), you interrupted Sarah several times (Behavior), which made it hard for her to share her ideas (Impact).” Feedback should also include suggestions for improvement and be delivered in a respectful, private setting. Equally important is receiving feedback with an open mind, without defensiveness, and viewing it as an opportunity to grow. Leaders should foster a culture where feedback is normalized, frequent, and expected. Encouraging two-way feedback helps teams continuously adapt, innovate, and build stronger working relationships.',
'https://www.example.com/video72'),

(73,
'Communication during difficult conversations is a vital skill for professionals, particularly in leadership roles. These conversations may involve delivering bad news, addressing performance issues, or handling conflicts. Successful communication in such scenarios requires preparation, empathy, and emotional intelligence. Start by clearly identifying the purpose of the conversation and planning the key messages. Choose an appropriate time and private setting to ensure a respectful dialogue. Use “I” statements to express concerns without sounding accusatory—for example, “I noticed a pattern…” rather than “You always…” Listen actively and validate the other person’s feelings, even if you disagree. Stay calm and open, and focus on solving the issue rather than assigning blame. Follow up after the conversation to ensure progress and maintain trust. Avoiding difficult conversations can lead to bigger problems over time. Leaders who handle them with care strengthen team dynamics and foster a culture of openness and accountability.',
'https://www.example.com/video73'),

(74,
'Cross-cultural communication refers to the ability to effectively communicate with people from different cultural backgrounds. As workplaces become more globalized and diverse, this skill is increasingly important. Cultural differences can affect communication styles, tone, gestures, time perception, decision-making, and expectations. Misunderstandings may arise when one interprets behavior through the lens of their own culture. To improve cross-cultural communication, it’s essential to develop cultural awareness, show empathy, and practice active listening. Avoid assumptions and ask clarifying questions when needed. Use clear, simple language and be mindful of idioms or jargon that might not translate well. Non-verbal communication also varies across cultures, so its important to understand cultural norms related to eye contact, personal space, and gestures. Organizations can support this skill through cultural sensitivity training and inclusive practices. Leaders who communicate effectively across cultures build stronger global teams, foster inclusion, and enhance collaboration.',
'https://www.example.com/video74'),

(75,
'Productivity is often misunderstood as simply doing more in less time, but true productivity is about achieving meaningful results efficiently. It involves working smarter, not harder, and aligning your tasks with your goals and values. Productive individuals focus on high-impact activities, manage their energy effectively, and minimize distractions. Key principles include setting clear priorities, breaking large tasks into smaller steps, using systems to track progress, and protecting deep work time. Common barriers to productivity include multitasking, lack of direction, poor planning, and digital distractions. Tools like the Eisenhower Matrix, Pomodoro Technique, and time-blocking can help individuals manage their workload. Reflecting on daily accomplishments and adjusting habits regularly also enhances productivity. Leaders can support productive teams by setting clear expectations, reducing unnecessary meetings, and fostering a culture that values focus and results over busyness. In essence, true productivity leads to better performance, satisfaction, and well-being.',
'https://www.example.com/video75'),

(76,
'Identifying your productivity style helps tailor your work habits to your strengths and preferences. People vary in how they approach tasks—some thrive on structure and detailed planning, while others prefer flexibility and creative flow. Understanding whether you’re a morning person or a night owl, whether you prefer working in silence or with background noise, and whether you’re deadline-driven or proactive can significantly affect your efficiency. Personality traits also influence productivity—introverts may prefer solo work, while extroverts may gain energy from collaboration. By aligning your work style with your natural rhythms, you can optimize performance and reduce stress. Self-assessment tools like the Kolbe Index, DISC, or Myers-Briggs can provide insights into your productivity tendencies. Teams can benefit by recognizing and respecting different working styles and assigning tasks accordingly. Ultimately, knowing your productivity style leads to more sustainable habits, better time management, and improved outcomes.',
'https://www.example.com/video76'),

(77,
'Goal setting is a powerful productivity tool that provides direction, motivation, and a sense of accomplishment. The SMART framework—Specific, Measurable, Achievable, Relevant, and Time-bound—helps ensure goals are clear and actionable. Vague goals like “be more productive” are less effective than SMART goals like “write a project outline by Friday.” Setting short-term and long-term goals provides both focus and big-picture perspective. Writing goals down, breaking them into smaller tasks, and tracking progress increases the likelihood of success. Review goals regularly to assess whether they’re still aligned with your values and priorities. Goal setting also enhances self-discipline and time management. Leaders can help their teams by aligning individual goals with organizational objectives, providing feedback, and celebrating milestones. In both personal and professional contexts, goal setting is a habit that empowers individuals to turn intentions into results and continuously improve.',
'https://www.example.com/video77'),

(78,
'Prioritization frameworks help individuals and teams focus on what truly matters, especially when faced with competing demands. One of the most well-known tools is the Eisenhower Matrix, which categorizes tasks into four quadrants based on urgency and importance. This helps users distinguish between tasks that need immediate attention, those that can be scheduled, delegated, or even eliminated. Another popular method is the ABCDE method, which ranks tasks by importance. The Pareto Principle (80/20 rule) suggests focusing on the 20% of tasks that yield 80% of results. Prioritization is not just about doing things right—it’s about doing the right things. It requires regular reflection and the courage to say no to low-value activities. Technology tools like task managers and planners can support this process. In teams, alignment on priorities ensures that effort is directed toward shared goals. Practicing effective prioritization reduces stress, increases productivity, and ensures meaningful progress.',
'https://www.example.com/video78');

UPDATE LessonContent
SET VideoURL = 'https://www.youtube.com/watch?v=sCQ0VYNCmKw'
WHERE LessonID BETWEEN 1 AND 78;

INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, QuestionOrder, Status) VALUES
-- Quizzes for Course 1: Strategic Leadership
(NULL, 1, 'Strategic Leadership Assessment', 'Leadership', 'Intermediate', 10, 20, 70.00, 'Course Assessment', 1, 1),

-- Quizzes for Lesson 3: Key Concepts of Strategic Leadership (ChapterID 1, CourseID 1)
(3, NULL, 'Strategic Concepts Check', 'Leadership Principles', 'Easy', 10, 15, 60.00, 'Practice', 1, 1),

-- Quizzes for Course 2: Time Management Mastery
(NULL, 2, 'Time Management Skills Evaluation', 'Time Management', 'Intermediate', 10, 25, 75.00, 'Course Assessment', 1, 1),

-- Quizzes for Lesson 6: The Pomodoro Technique Explained (ChapterID 5, CourseID 2)
(6, NULL, 'Pomodoro Technique Quiz', 'Productivity Methods', 'Easy', 10, 12, 60.00, 'Practice', 1, 1),

-- Quizzes for Course 3: Mastering Self-Awareness
(NULL, 3, 'Self-Awareness Core Concepts', 'Emotional Intelligence', 'Intermediate', 10, 18, 70.00, 'Course Assessment', 1, 1),

-- Quizzes for Lesson 8: Journaling for Self-Discovery (ChapterID 8, CourseID 3)
(8, NULL, 'Journaling Benefits Quiz', 'Self-Discovery', 'Easy', 10, 10, 50.00, 'Practice', 1, 1),

-- Quizzes for Course 4: Public Speaking Essentials
(NULL, 4, 'Public Speaking Readiness Test', 'Communication', 'Intermediate', 10, 20, 70.00, 'Course Assessment', 1, 1),

-- Quizzes for Course 5: Leadership Fundamentals
(NULL, 5, 'Leadership Principles Quiz', 'Leadership', 'Intermediate', 10, 18, 65.00, 'Course Assessment', 1, 1),

-- Quizzes for Lesson 14: Decision Making in Leadership (ChapterID 14, CourseID 5)
(14, NULL, 'Leadership Decision Scenarios', 'Decision Making', 'Medium', 10, 15, 70.00, 'Practice', 1, 1),

-- Quizzes for Course 6: Emotional Intelligence at Work
(NULL, 6, 'Workplace EQ Assessment', 'Emotional Intelligence', 'Intermediate', 10, 20, 70.00, 'Course Assessment', 1, 1),

-- Quizzes for Course 7: Problem Solving Techniques
(NULL, 7, 'Problem Solving Fundamentals Quiz', 'Problem Solving', 'Intermediate', 10, 15, 65.00, 'Course Assessment', 1, 1),

-- Quizzes for Lesson 20: Introduction to Problem Solving (ChapterID 20, CourseID 7)
(20, NULL, 'Problem Definition Check', 'Problem Solving', 'Easy', 10, 12, 60.00, 'Practice', 1, 1);



INSERT INTO Questions (QuizID, QuestionContent, QuestionType, AnswerKey, Explanation) VALUES
-- Questions for 'Strategic Leadership Assessment' (QuizID 1)
(1, 'Which of the following is NOT a core characteristic of strategic leadership?', 'Multiple Choice', NULL, NULL),
(1, 'Explain how a strategic leader fosters innovation within an organization.', 'Short Answer', 'Focus on vision, empowerment, risk-taking, and continuous learning.', 'Strategic leaders create an environment where innovation thrives by encouraging risk-taking, empowering employees, and continuously seeking new ideas aligned with the long-term vision.'),
(1, 'What is the primary purpose of a SWOT analysis in strategic planning?', 'Multiple Choice', NULL, NULL),
(1, 'Describe the role of adaptability in strategic leadership in a rapidly changing market.', 'Short Answer', 'Ability to pivot, adjust plans, and embrace change.', 'In a rapidly changing market, adaptability allows strategic leaders to quickly adjust plans, reallocate resources, and embrace new opportunities or mitigate threats, ensuring the organization remains relevant and competitive.'),
(1, 'A strategic leader is primarily concerned with:', 'Multiple Choice', NULL, NULL),
(1, 'What is the difference between operational and strategic planning?', 'Short Answer', 'Operational is short-term/daily, strategic is long-term/future.', 'Operational planning focuses on day-to-day activities and short-term goals, while strategic planning deals with the organization long-term vision and overarching objectives.'),
(1, 'Which component of strategic leadership involves communicating a clear direction?', 'Multiple Choice', NULL, NULL),
(1, 'How does a strategic leader ensure alignment across different departments?', 'Short Answer', 'Clear communication of vision, common goals, cross-functional collaboration.', 'Strategic leaders ensure alignment by clearly communicating the organizational vision, setting common goals that transcend departmental boundaries, and fostering cross-functional collaboration.'),
(1, 'What does it mean to "lead by example" in a strategic context?', 'Multiple Choice', NULL, NULL),
(1, 'Discuss the importance of foresight in strategic decision-making.', 'Short Answer', 'Anticipating trends, mitigating risks, seizing opportunities.', 'Foresight in strategic decision-making involves anticipating future trends, potential challenges, and emerging opportunities, allowing leaders to make proactive rather than reactive choices.'),


(2, 'Strategic leadership primarily focuses on : ', 'Multiple Choice', NULL, NULL),
(2, 'The "big picture" thinking in strategic leadership refers to:', 'Multiple Choice', NULL, NULL),
(2, 'Which of these best defines a strategic vision?', 'Multiple Choice', NULL, NULL),
(2, 'Explain why alignment is critical for strategic execution.', 'Short Answer', 'Ensures everyone works towards same goal, avoids wasted effort.', 'Alignment ensures that all parts of an organization are working cohesively towards the same strategic goals, preventing fragmented efforts and maximizing resource utilization.'),
(2, 'What role does communication play in implementing a new strategy?', 'Multiple Choice', NULL, NULL),
(2, 'How does strategic leadership differ from traditional management?', 'Short Answer', 'Strategic focuses on long-term, vision; traditional on short-term, operations.', 'Strategic leadership emphasizes long-term vision and adaptability, while traditional management often focuses on maintaining current operations and short-term efficiency.'),
(2, 'A strategic leader encourages:', 'Multiple Choice', NULL, NULL),
(2, 'Define "organizational culture" in the context of strategic leadership.', 'Short Answer', 'Shared values and norms guiding behavior.', 'Organizational culture refers to the shared values, beliefs, and norms that influence how employees interact and perform, and strategic leaders shape it to support strategic objectives.'),
(2, 'The term "proactive decision" in strategy means:', 'Multiple Choice', NULL, NULL),
(2, 'Give an example of a strategic objective.', 'Short Answer', 'Increase market share by X%, expand into Y new markets.', 'An example of a strategic objective could be: "To increase market share by 15% in the next three years by expanding into emerging Asian markets."'),

-- Questions for 'Time Management Skills Evaluation' (QuizID 3)
(3, 'Which time management matrix helps categorize tasks by urgency and importance?', 'Multiple Choice', NULL, NULL),
(3, 'List three common time-wasting activities and how to avoid them.', 'Short Answer', 'Examples: social media, unnecessary meetings, perfectionism. Avoidance: limit access, set agendas, set realistic goals.', 'Common time-wasting activities include excessive social media, unnecessary meetings, and striving for perfectionism. These can be avoided by setting time limits for social media, creating clear meeting agendas, and setting realistic, achievable standards.'),
(3, 'What is the recommended duration for a focused work session in the Pomodoro Technique?', 'Multiple Choice', NULL, NULL),
(3, 'Explain the concept of "time blocking" in personal productivity.', 'Short Answer', 'Allocating specific time slots for specific tasks.', 'Time blocking involves scheduling specific periods in your calendar for dedicated work on particular tasks or projects, treating these time slots as non-negotiable appointments.'),
(3, 'Which of these is a SMART goal component?', 'Multiple Choice', NULL, NULL),
(3, 'Describe the "Eat the Frog" principle.', 'Short Answer', 'Do your most difficult task first in the day.', 'The "Eat the Frog" principle suggests tackling your most challenging or important task first thing in the morning, ensuring it gets done before other distractions arise.'),
(3, 'What is the purpose of a "brain dump" in task management?', 'Multiple Choice', NULL, NULL),
(3, 'How does delegating tasks improve your personal time management?', 'Short Answer', 'Frees up time for high-value tasks, empowers others.', 'Delegating tasks allows you to free up your own time to focus on higher-priority or more complex responsibilities, while also empowering and developing the skills of others.'),
(3, 'Which tool is best for visualizing project deadlines?', 'Multiple Choice', NULL, NULL),
(3, 'What is the benefit of regularly reviewing your time management system?', 'Short Answer', 'Identifies what works, allows for adjustments and improvements.', 'Regularly reviewing your time management system helps you identify which strategies are effective, pinpoint areas for improvement, and make necessary adjustments to optimize your productivity.'),

-- Questions for 'Pomodoro Technique Quiz' (QuizID 4)
(4, 'The Pomodoro Technique involves short breaks after how many minutes of focused work?', 'Multiple Choice', NULL, NULL),
(4, 'What is the purpose of the 5-minute break in Pomodoro?', 'Multiple Choice', NULL, NULL),
(4, 'After how many Pomodoros should you take a longer break?', 'Multiple Choice', NULL, NULL),
(4, 'Which of these is a core principle of Pomodoro?', 'Multiple Choice', NULL, NULL),
(4, 'Explain how the Pomodoro Technique helps in maintaining focus.', 'Short Answer', 'Breaks prevent burnout, timer creates urgency.', 'The Pomodoro Technique helps maintain focus by breaking down work into manageable chunks, with short, regular breaks that prevent mental fatigue and promote sustained concentration. The timer creates a sense of urgency, encouraging dedicated work.'),
(4, 'Can you interrupt a Pomodoro once it has started?', 'Multiple Choice', NULL, NULL),
(4, 'What should you do during a long break (e.g., 15-30 minutes)?', 'Short Answer', 'Relax, stretch, disconnect from work.', 'During a long break, you should disengage from work completely. This could involve stretching, taking a walk, getting a snack, or engaging in a light, non-work-related activity to fully recharge.'),
(4, 'The name "Pomodoro" comes from:', 'Multiple Choice', NULL, NULL),
(4, 'Is the Pomodoro Technique suitable for all types of work?', 'Multiple Choice', NULL, NULL),
(4, 'How does Pomodoro help in estimating task completion time?', 'Short Answer', 'Breaks down tasks into measurable units (Pomodoros).', 'By breaking down tasks into 25-minute Pomodoros, the technique helps in estimating how many such units a task will take, making time estimation more accurate and manageable.'),

-- Questions for 'Self-Awareness Core Concepts' (QuizID 5)
(5, 'Internal self-awareness refers to:', 'Multiple Choice', NULL, NULL),
(5, 'How can journaling contribute to increased self-awareness?', 'Short Answer', 'Reflects thoughts, emotions, patterns, helps understand reactions.', 'Journaling provides a space for reflection, allowing individuals to record thoughts, emotions, and reactions. This practice helps in identifying patterns, understanding triggers, and gaining insight into one inner world, thereby increasing self-awareness.'),
(5, 'Which of these is an example of external self-awareness?', 'Multiple Choice', NULL, NULL),
(5, 'Why is feedback important for developing self-awareness?', 'Short Answer', 'Provides outside perspective, reveals blind spots.', 'Feedback from others offers an external perspective on how your actions and behaviors are perceived, revealing blind spots and areas for improvement that you might not be aware of internally.'),
(5, 'The ability to understand your own emotions is called:', 'Multiple Choice', NULL, NULL),
(5, 'Describe the role of mindfulness in building self-awareness.', 'Short Answer', 'Being present, observing thoughts without judgment.', 'Mindfulness involves intentionally focusing on the present moment and observing your thoughts, feelings, and bodily sensations without judgment. This practice helps in becoming more attuned to your inner state, fostering greater self-awareness.'),
(5, 'Which emotion is typically associated with high self-awareness?', 'Multiple Choice', NULL, NULL),
(5, 'How can understanding your personal values enhance self-awareness?', 'Short Answer', 'Guides decisions, aligns actions with beliefs.', 'Understanding personal values helps you recognize what truly matters to you, guiding your decisions and ensuring your actions are aligned with your deepest beliefs, thus strengthening your sense of self.'),
(5, 'What is a "blind spot" in the context of self-awareness?', 'Multiple Choice', NULL, NULL),
(5, 'Why is self-awareness considered the foundation of emotional intelligence?', 'Short Answer', 'Cannot manage or understand others emotions without understanding your own.', 'Self-awareness is the foundation because you cannot effectively manage your own emotions or understand the emotions of others without first recognizing and understanding your own internal states, thoughts, and feelings.'),

-- Questions for 'Journaling Benefits Quiz' (QuizID 6)
(6, 'Which is a common benefit of journaling for self-awareness?', 'Multiple Choice', NULL, NULL),
(6, 'Journaling primarily helps you:', 'Multiple Choice', NULL, NULL),
(6, 'Is it necessary to write in a journal every day to see benefits?', 'Multiple Choice', NULL, NULL),
(6, 'Which of these is a good journaling practice?', 'Multiple Choice', NULL, NULL),
(6, 'Explain how journaling can help in processing emotions.', 'Short Answer', 'Allows expression, creates distance, helps identify patterns.', 'Journaling provides a safe outlet to express and explore emotions. By writing them down, you can create distance from intense feelings, identify triggers, and gain clarity on their origins, aiding emotional processing.'),
(6, 'Can journaling help in problem-solving?', 'Multiple Choice', NULL, NULL),
(6, 'What kind of topics are suitable for journaling?', 'Short Answer', 'Thoughts, feelings, daily events, goals, gratitude.', 'Suitable topics for journaling include your thoughts, feelings, daily experiences, challenges, goals, aspirations, and anything you are grateful for or concerned about.'),
(6, 'Is there a "right" way to journal?', 'Multiple Choice', NULL, NULL),
(6, 'How does regular journaling affect stress levels?', 'Multiple Choice', NULL, NULL),
(6, 'Why is privacy important when journaling for self-awareness?', 'Short Answer', 'Encourages honesty and vulnerability without judgment.', 'Privacy is important because it allows you to be completely honest and vulnerable without fear of judgment from others, leading to deeper self-reflection and more authentic insights.'),

-- Questions for 'Public Speaking Readiness Test' (QuizID 7)
(7, 'Which of these is crucial for engaging your audience during a speech?', 'Multiple Choice', NULL, NULL),
(7, 'Name two techniques to manage public speaking anxiety.', 'Short Answer', 'Deep breathing, visualization, practice.', 'Two effective techniques to manage public speaking anxiety are deep breathing exercises before and during the speech, and visualization, where you mentally rehearse a successful and confident delivery.'),
(7, 'What is the purpose of an effective introduction in public speaking?', 'Multiple Choice', NULL, NULL),
(7, 'How can visual aids enhance a presentation?', 'Short Answer', 'Clarify complex info, engage audience, aid memory.', 'Visual aids can enhance a presentation by clarifying complex information, making it more digestible, engaging the audience visually, and helping them retain key points more effectively.'),
(7, 'Which type of audience analysis focuses on their knowledge level of the topic?', 'Multiple Choice', NULL, NULL),
(7, 'Why is it important to practice your speech aloud?', 'Short Answer', 'Identifies awkward phrasing, improves flow and timing.', 'Practicing aloud helps you identify awkward phrasing or transitions, refine your delivery, ensure the speech flows naturally, and manage your timing effectively.'),
(7, 'Which posture conveys confidence in public speaking?', 'Multiple Choice', NULL, NULL),
(7, 'Describe "active listening" in the context of audience interaction.', 'Short Answer', 'Paying full attention, understanding, responding appropriately.', 'Active listening in audience interaction involves giving your full attention to audience questions or comments, seeking to understand their underlying message, and responding thoughtfully rather than defensively.'),
(7, 'What is the ideal amount of text on a presentation slide?', 'Multiple Choice', NULL, NULL),
(7, 'How can storytelling benefit your public speaking?', 'Short Answer', 'Makes message relatable, memorable, creates emotional connection.', 'Storytelling makes your message more relatable and memorable by connecting with the audience on an emotional level, illustrating points vividly, and making complex ideas easier to grasp.'),

-- Questions for 'Leadership Principles Quiz' (QuizID 8)
(8, 'A leader who empowers their team typically does what?', 'Multiple Choice', NULL, NULL),
(8, 'What is the difference between a manager and a leader?', 'Short Answer', 'Manager administers, leader innovates; manager maintains, leader develops.', 'While a manager focuses on administering and maintaining systems, a leader innovates and develops. Managers often deal with processes, whereas leaders inspire and motivate people towards a vision.'),
(8, 'Which leadership style involves making decisions with minimal input from others?', 'Multiple Choice', NULL, NULL),
(8, 'Explain the concept of "situational leadership".', 'Short Answer', 'Adapting leadership style to follower readiness.', 'Situational leadership is a theory where leaders adapt their style and approach to fit the development level and readiness of their individual followers or team members for a specific task.'),
(8, 'Effective leaders are also skilled at:', 'Multiple Choice', NULL, NULL),
(8, 'Why is integrity crucial for a leader?', 'Short Answer', 'Builds trust, sets ethical standard, inspires confidence.', 'Integrity is crucial because it builds trust and credibility with followers, sets an an ethical standard for the entire team, and inspires confidence and loyalty.'),
(8, 'Which is a characteristic of a transformational leader?', 'Multiple Choice', NULL, NULL),
(8, 'How does constructive feedback benefit a leader?', 'Short Answer', 'Identifies blind spots, promotes growth, improves performance.', 'Constructive feedback helps leaders identify their blind spots, understand their impact on others, promotes personal and professional growth, and ultimately leads to improved leadership performance.'),
(8, 'Which leadership approach focuses on clear goals and rewards?', 'Multiple Choice', NULL, NULL),
(8, 'Discuss the importance of emotional intelligence in leadership.', 'Short Answer', 'Understanding self and others, empathy, managing conflict.', 'Emotional intelligence in leadership is vital for understanding and managing one own emotions, empathizing with team members, resolving conflicts, and building stronger, more productive relationships.'),

-- Questions for 'Leadership Decision Scenarios' (QuizID 9)
(9, 'You need to make a quick decision under pressure. What is your priority?', 'Multiple Choice', NULL, NULL),
(9, 'A team member is underperforming. What is the most effective initial approach?', 'Multiple Choice', NULL, NULL),
(9, 'Your team is resistant to a new company policy. How do you address this as a leader?', 'Multiple Choice', NULL, NULL),
(9, 'Explain a time you had to make a tough decision as a leader and its outcome.', 'Short Answer', 'Requires personal experience, focus on process and learning.', '*(Requires personal reflection from the user. Expected answer should describe a decision, the process, challenges, and lessons learned.)*'),
(9, 'How would you handle a conflict between two valuable team members?', 'Multiple Choice', NULL, NULL),
(9, 'What is your approach to motivating a demotivated team?', 'Short Answer', 'Identify root cause, offer support, clarify purpose, celebrate small wins.', 'My approach would involve first understanding the root cause of demotivation, then offering support and resources, clarifying the purpose and impact of their work, and celebrating small achievements to rebuild morale.'),
(9, 'A project deadline is approaching, and your team is behind schedule. What do you do?', 'Multiple Choice', NULL, NULL),
(9, 'Describe how you would delegate a complex task to a junior team member.', 'Short Answer', 'Clear instructions, resources, support, check-ins, trust.', 'I would provide clear instructions, ensure they have the necessary resources and support, set up regular check-ins without micromanaging, and express trust in their ability to learn and complete the task.'),
(9, 'Which is the best way to foster innovation within your team?', 'Multiple Choice', NULL, NULL),
(9, 'You receive negative feedback about your leadership style. How do you respond?', 'Short Answer', 'Listen actively, ask clarifying questions, thank them, reflect, make a plan.', 'I would listen actively without interrupting, ask clarifying questions to understand the feedback fully, thank the person for their honesty, reflect on the feedback, and develop a plan for improvement.'),

-- Questions for 'Workplace EQ Assessment' (QuizID 10)
(10, 'Empathy in the workplace involves:', 'Multiple Choice', NULL, NULL),
(10, 'Give an example of how self-regulation can prevent a conflict in the workplace.', 'Short Answer', 'Pause before reacting, manage anger, calm down.', 'If a colleague makes a critical comment, self-regulation would involve pausing before reacting impulsively, taking a deep breath to manage anger, and choosing a calm, constructive response instead of an immediate defensive one.'),
(10, 'Which of these is a sign of high social skills?', 'Multiple Choice', NULL, NULL),
(10, 'How does understanding your own emotional triggers help you at work?', 'Short Answer', 'Prevents overreactions, allows for proactive management.', 'Understanding your emotional triggers helps you anticipate situations that might provoke a strong reaction, allowing you to proactively manage your response and prevent unnecessary conflicts or emotional outbursts.'),
(10, 'The ability to understand how your words affect others is part of:', 'Multiple Choice', NULL, NULL),
(10, 'Describe a situation where displaying self-awareness was beneficial in your professional life.', 'Short Answer', 'Recognizing a weakness, admitting a mistake, seeking help.', '*(Requires personal reflection from the user. Expected answer should describe a situation where acknowledging one own feelings or limitations led to a positive outcome.)*'),
(10, 'Which component of EQ helps you bounce back from setbacks?', 'Multiple Choice', NULL, NULL),
(10, 'How can active listening improve emotional intelligence in team interactions?', 'Short Answer', 'Shows respect, builds trust, helps understand underlying emotions.', 'Active listening demonstrates respect, builds trust, and allows you to grasp not just the words but also the underlying emotions and intentions of others, leading to more empathetic and effective communication.'),
(10, 'Which action demonstrates good relationship management?', 'Multiple Choice', NULL, NULL),
(10, 'Why is it important for leaders to have high emotional intelligence?', 'Short Answer', 'Inspires trust, resolves conflict, motivates teams, handles stress.', 'Leaders with high emotional intelligence can inspire trust, effectively resolve conflicts, motivate their teams, and handle stress with greater resilience, leading to a more positive and productive work environment.'),

-- Questions for 'Problem Solving Fundamentals Quiz' (QuizID 11)
(11, 'The "5 Whys" technique is primarily used for:', 'Multiple Choice', NULL, NULL),
(11, 'Briefly explain the importance of clearly defining a problem before attempting to solve it.', 'Short Answer', 'Ensures correct problem is addressed, avoids wasted effort.', 'Clearly defining a problem ensures that efforts are directed at the actual issue, rather than symptoms. It helps in understanding the scope and context, preventing wasted resources on solving the wrong problem.'),
(11, 'Which step typically comes after identifying the problem?', 'Multiple Choice', NULL, NULL),
(11, 'What is the benefit of brainstorming multiple solutions?', 'Short Answer', 'Increases options, encourages creativity, finds optimal solutions.', 'Brainstorming multiple solutions helps in exploring a wide range of possibilities, fosters creativity, and increases the likelihood of finding innovative and optimal solutions rather than settling for the first idea.'),
(11, 'When evaluating potential solutions, what should you consider?', 'Multiple Choice', NULL, NULL),
(11, 'Describe the difference between a problem and a symptom.', 'Short Answer', 'Problem is root cause, symptom is visible effect.', 'A problem is the underlying cause of an issue, while a symptom is a visible effect or indicator that a problem exists. Solving symptoms without addressing the root problem leads to recurrence.'),
(11, 'Which approach encourages breaking down complex problems?', 'Multiple Choice', NULL, NULL),
(11, 'Why is it important to test a solution before full implementation?', 'Short Answer', 'Identifies flaws, minimizes risk, allows for adjustments.', 'Testing a solution on a small scale helps identify any flaws or unforeseen issues, minimizes risk, and allows for adjustments and refinements before a full-scale implementation.'),
(11, 'What is a common pitfall in problem-solving?', 'Multiple Choice', NULL, NULL),
(11, 'How does collaboration enhance the problem-solving process?', 'Short Answer', 'Diverse perspectives, broader knowledge, shared ownership.', 'Collaboration brings together diverse perspectives, a broader range of knowledge and skills, and fosters shared ownership, leading to more comprehensive and effective solutions.'),

-- Questions for 'Problem Definition Check' (QuizID 12)
(12, 'The first step in effective problem-solving is usually:', 'Multiple Choice', NULL, NULL),
(12, 'What does a well-defined problem statement include?', 'Multiple Choice', NULL, NULL),
(12, 'Why is it crucial to distinguish between a problem and its symptoms?', 'Multiple Choice', NULL, NULL),
(12, 'Explain how asking "why" repeatedly (e.g., 5 Whys) helps in problem definition.', 'Short Answer', 'Uncovers root cause by iterative questioning.', 'Asking "why" repeatedly helps to dig deeper beyond immediate symptoms to uncover the underlying root cause of a problem, leading to more effective and lasting solutions.'),
(12, 'Which of these indicates a problem is clearly defined?', 'Multiple Choice', NULL, NULL),
(12, 'What role do assumptions play in problem definition?', 'Short Answer', 'Can bias analysis, should be identified and validated.', 'Assumptions can introduce bias and limit the scope of a problem if not identified and validated. Recognizing assumptions helps in approaching the problem with a more open and accurate perspective.'),
(12, 'To confirm problem definition, you should:', 'Multiple Choice', NULL, NULL),
(12, 'Give an example of a vague problem statement vs. a clear one.', 'Short Answer', 'Vague: Sales are down. Clear: Sales of Product X decreased by 10% in Q2 due to competitor Y.', 'A vague statement might be: "Sales are down." A clear problem statement would be: "Sales of Product X in the Western region decreased by 15% last quarter, primarily due to increased competitor promotional activity."'),
(12, 'Which technique helps visually represent causes and effects of a problem?', 'Multiple Choice', NULL, NULL),
(12, 'Why is involving stakeholders important during problem definition?', 'Short Answer', 'Ensures comprehensive understanding, builds buy-in.', 'Involving stakeholders ensures that all relevant perspectives are considered, leading to a comprehensive understanding of the problem and fostering buy-in for future solutions.')




INSERT INTO QuestionOptions (QuestionID, OptionContent, IsCorrect) VALUES
-- Options for QuestionID 1 (QuizID 1: Strategic Leadership Assessment)
(1, 'Foresight and vision', 0),
(1, 'Adaptability and innovation', 0),
(1, 'Focus on short-term operational efficiency', 1), -- Correct for NOT a characteristic
(1, 'Empowerment and influence', 0),
-- Options for QuestionID 3 (QuizID 1)
(3, 'To identify external threats only', 0),
(3, 'To assess an organization''s internal strengths and weaknesses, and external opportunities and threats', 1),
(3, 'To set financial targets for the next quarter', 0),
(3, 'To analyze past performance metrics', 0),
-- Options for QuestionID 5 (QuizID 1)
(5, 'Day-to-day task management', 0),
(5, 'Long-term organizational growth and sustainability', 1),
(5, 'Meeting weekly sales quotas', 0),
(5, 'Employee grievance handling', 0),
-- Options for QuestionID 7 (QuizID 1)
(7, 'Delegating all strategic tasks', 0),
(7, 'Vision development and articulation', 1),
(7, 'Avoiding any form of public speaking', 0),
(7, 'Focusing only on current profits', 0),
-- Options for QuestionID 9 (QuizID 1)
(9, 'To always be the first to complete a task', 0),
(9, 'To demonstrate the values and behaviors you expect from your team', 1),
(9, 'To take on all the difficult tasks yourself', 0),
(9, 'To only give instructions without participating', 0),


-- Options for QuestionID 11 (QuizID 2: Strategic Concepts Check)
(11, 'Daily operational tasks', 0),
(11, 'Long-term vision and organizational goals', 1),
(11, 'Individual employee performance reviews', 0),
(11, 'Short-term financial reporting', 0),
-- Options for QuestionID 12 (QuizID 2)
(12, 'Focusing only on immediate deadlines', 0),
(12, 'Understanding the interconnectedness of various business functions and external factors', 1),
(12, 'Delegating all major decisions to subordinates', 0),
(12, 'Ignoring market trends to stick to the original plan', 0),
-- Options for QuestionID 13 (QuizID 2)
(13, 'A detailed action plan for the next week.', 0),
(13, 'A clear, aspirational image of the desired future state of the organization.', 1),
(13, 'A list of current employee strengths and weaknesses.', 0),
(13, 'A report on last year''s financial performance.', 0),
-- Options for QuestionID 15 (QuizID 2)
(15, 'It helps in hiding critical information from competitors.', 0),
(15, 'It ensures everyone understands their role and the overall direction.', 1),
(15, 'It eliminates the need for leadership involvement.', 0),
(15, 'It is only necessary during times of crisis.', 0),
-- Options for QuestionID 17 (QuizID 2)
(17, 'Rigid adherence to established procedures', 0),
(17, 'Risk aversion and maintaining the status quo', 0),
(17, 'Innovation, adaptability, and empowered decision-making', 1),
(17, 'Strict hierarchy and top-down control', 0),
-- Options for QuestionID 19 (QuizID 2)
(19, 'A decision made quickly without much thought.', 0),
(19, 'A decision made in response to an existing problem.', 0),
(19, 'A decision made in anticipation of future events or trends.', 1),
(19, 'A decision based solely on past experiences.', 0),


-- Options for QuestionID 21 (QuizID 3: Time Management Skills Evaluation)
(21, 'Gantt Chart', 0),
(21, 'Kanban Board', 0),
(21, 'Eisenhower Matrix', 1),
(21, 'PERT Chart', 0),
-- Options for QuestionID 23 (QuizID 3)
(23, '10 minutes', 0),
(23, '25 minutes', 1),
(23, '45 minutes', 0),
(23, '60 minutes', 0),
-- Options for QuestionID 25 (QuizID 3)
(25, 'Specific', 1),
(25, 'Difficult', 0),
(25, 'Ambiguous', 0),
(25, 'Unrealistic', 0),
-- Options for QuestionID 27 (QuizID 3)
(27, 'To distract yourself from work', 0),
(27, 'To quickly jot down all tasks and ideas floating in your mind', 1),
(27, 'To share your thoughts with colleagues', 0),
(27, 'To analyze historical data', 0),
-- Options for QuestionID 29 (QuizID 3)
(29, 'Flowchart', 0),
(29, 'Gantt Chart', 1),
(29, 'Mind Map', 0),
(29, 'Fishbone Diagram', 0),


-- Options for QuestionID 31 (QuizID 4: Pomodoro Technique Quiz)
(31, '5 minutes', 1),
(31, '15 minutes', 0),
(31, '30 minutes', 0),
(31, 'No breaks are taken', 0),
-- Options for QuestionID 32 (QuizID 4)
(32, 'To check social media', 0),
(32, 'To relax and recharge your mind', 1),
(32, 'To start a new task immediately', 0),
(32, 'To send emails', 0),
-- Options for QuestionID 33 (QuizID 4)
(33, 'After 1 Pomodoro', 0),
(33, 'After 2 Pomodoros', 0),
(33, 'After 3 Pomodoros', 0),
(33, 'After 4 Pomodoros', 1),
-- Options for QuestionID 34 (QuizID 4)
(34, 'Multitasking is encouraged.', 0),
(34, 'Focus for short, intense bursts followed by breaks.', 1),
(34, 'Work until you feel tired, then take a long break.', 0),
(34, 'Only use it for creative tasks.', 0),
-- Options for QuestionID 36 (QuizID 4)
(36, 'Yes, at any time for any reason.', 0),
(36, 'No, ideally you should complete the 25-minute session without interruption.', 1),
(36, 'Only if someone calls you.', 0),
(36, 'Only for urgent emails.', 0),
-- Options for QuestionID 38 (QuizID 4)
(38, 'A type of clock', 1),
(38, 'An Italian dish', 0),
(38, 'The inventor''s last name', 0),
(38, 'A specific time management software', 0),
-- Options for QuestionID 39 (QuizID 4)
(39, 'Yes, it is universally effective for everyone and every task.', 0),
(39, 'No, some people or tasks may benefit more from other techniques.', 1),
(39, 'Only for tasks requiring creativity.', 0),
(39, 'Only for very short tasks.', 0),


-- Options for QuestionID 41 (QuizID 5: Self-Awareness Core Concepts)
(41, 'Understanding how others perceive you', 0),
(41, 'Recognizing your own thoughts, emotions, and values', 1),
(41, 'Being aware of current events', 0),
(41, 'Knowing your job description perfectly', 0),
-- Options for QuestionID 43 (QuizID 5)
(43, 'Knowing your own strengths and weaknesses.', 0),
(43, 'Understanding how your behavior impacts others.', 1),
(43, 'Being able to read other people''s minds.', 0),
(43, 'Having a clear vision for the future.', 0),
-- Options for QuestionID 45 (QuizID 5)
(45, 'Self-motivation', 0),
(45, 'Empathy', 0),
(45, 'Self-awareness', 1),
(45, 'Social skills', 0),
-- Options for QuestionID 47 (QuizID 5)
(47, 'Anger', 0),
(47, 'Frustration', 0),
(47, 'Humility', 1),
(47, 'Arrogance', 0),
-- Options for QuestionID 49 (QuizID 5)
(49, 'A skill you are not good at.', 0),
(49, 'An aspect of your behavior or personality that you are unaware of, but others can see.', 1),
(49, 'A secret goal you have.', 0),
(49, 'A task you keep forgetting to do.', 0),


-- Options for QuestionID 51 (QuizID 6: Journaling Benefits Quiz)
(51, 'Improved physical strength', 0),
(51, 'Increased clarity on thoughts and emotions', 1),
(51, 'Better memory for factual information', 0),
(51, 'Enhanced financial literacy', 0),
-- Options for QuestionID 52 (QuizID 6)
(52, 'Memorize facts more easily', 0),
(52, 'Reflect on your inner thoughts and feelings', 1),
(52, 'Impress others with your writing', 0),
(52, 'Develop typing speed', 0),
-- Options for QuestionID 53 (QuizID 6)
(53, 'Yes, without fail.', 0),
(53, 'No, consistency over time is more important than daily adherence.', 1),
(53, 'Only if you have a lot of free time.', 0),
(53, 'Only when you are feeling stressed.', 0),
-- Options for QuestionID 54 (QuizID 6)
(54, 'Focusing on external events only', 0),
(54, 'Writing without self-censorship or judgment', 1),
(54, 'Only writing about positive experiences', 0),
(54, 'Always writing in perfect grammar and spelling', 0),
-- Options for QuestionID 56 (QuizID 6)
(56, 'No, journaling is only for emotional reflection.', 0),
(56, 'Yes, by helping organize thoughts and identify solutions.', 1),
(56, 'Only for mathematical problems.', 0),
(56, 'Only if you are a professional problem solver.', 0),
-- Options for QuestionID 58 (QuizID 6)
(58, 'Yes, there is one universally correct journaling method.', 0),
(58, 'No, it is a personal practice with many valid approaches.', 1),
(58, 'Only if you use a specific type of journal.', 0),
(58, 'Only if you follow strict rules.', 0),
-- Options for QuestionID 59 (QuizID 6)
(59, 'Increases stress due to daily commitment.', 0),
(59, 'Helps reduce stress by externalizing thoughts and emotions.', 1),
(59, 'Has no impact on stress levels.', 0),
(59, 'Only reduces stress for certain personality types.', 0),


-- Options for QuestionID 61 (QuizID 7: Public Speaking Readiness Test)
(61, 'Reading directly from notes', 0),
(61, 'Maintaining strong eye contact and using engaging gestures', 1),
(61, 'Speaking in a monotone voice', 0),
(61, 'Avoiding any interaction with the audience', 0),
-- Options for QuestionID 63 (QuizID 7)
(63, 'To confuse the audience', 0),
(63, 'To grab attention, establish credibility, and preview the topic', 1),
(63, 'To summarize the entire speech upfront', 0),
(63, 'To delay the main content', 0),
-- Options for QuestionID 65 (QuizID 7)
(65, 'Demographic analysis', 0),
(65, 'Situational analysis', 0),
(65, 'Psychological analysis', 1),
(65, 'Environmental analysis', 0),
-- Options for QuestionID 67 (QuizID 7)
(67, 'Slouched shoulders and looking down', 0),
(67, 'Standing tall with open body language and making eye contact', 1),
(67, 'Crossing your arms tightly', 0),
(67, 'Pacing rapidly across the stage', 0),
-- Options for QuestionID 69 (QuizID 7)
(69, 'As much as possible to be thorough.', 0),
(69, 'Minimal text, focusing on key points and visuals.', 1),
(69, 'Only bullet points, no full sentences.', 0),
(69, 'Long paragraphs to ensure all information is present.', 0),


-- Options for QuestionID 71 (QuizID 8: Leadership Principles Quiz)
(71, 'Gives detailed instructions for every task', 0),
(71, 'Trusts team members with responsibilities and supports their growth', 1),
(71, 'Monitors every step of a project closely', 0),
(71, 'Makes all decisions independently without team input', 0),
-- Options for QuestionID 73 (QuizID 8)
(73, 'Autocratic', 1),
(73, 'Democratic', 0),
(73, 'Laissez-faire', 0),
(73, 'Transformational', 0),
-- Options for QuestionID 75 (QuizID 8)
(75, 'Ignoring team member concerns', 0),
(75, 'Active listening and clear communication', 1),
(75, 'Micromanaging every detail', 0),
(75, 'Avoiding conflict at all costs', 0),
-- Options for QuestionID 77 (QuizID 8)
(77, 'Transactional leadership', 0),
(77, 'Servant leadership', 0),
(77, 'Transformational leadership', 1),
(77, 'Autocratic leadership', 0),
-- Options for QuestionID 79 (QuizID 8)
(79, 'Transactional leadership', 1),
(79, 'Charismatic leadership', 0),
(79, 'Situational leadership', 0),
(79, 'Authentic leadership', 0),


-- Options for QuestionID 81 (QuizID 9: Leadership Decision Scenarios)
(81, 'Gathering all possible data, even if it delays the decision.', 0),
(81, 'Making a decision without consulting anyone.', 0),
(81, 'Assessing the immediate impact and making the best decision with available information.', 1),
(81, 'Waiting for others to make the decision.', 0),
-- Options for QuestionID 82 (QuizID 9)
(82, 'Immediately remove them from the team.', 0),
(82, 'Ignore it and hope it improves.', 0),
(82, 'Schedule a private conversation to understand the issues and offer support.', 1),
(82, 'Publicly call them out during a team meeting.', 0),
-- Options for QuestionID 83 (QuizID 9)
(83, 'Announce it as final and non-negotiable.', 0),
(83, 'Dismiss their concerns as unjustified.', 0),
(83, 'Hold a discussion to listen to their concerns and explain the rationale.', 1),
(83, 'Blame upper management for the policy.', 0),
-- Options for QuestionID 85 (QuizID 9)
(85, 'Take sides with one team member.', 0),
(85, 'Ignore the conflict until it resolves itself.', 0),
(85, 'Mediate a discussion, focusing on solutions and mutual understanding.', 1),
(85, 'Tell both team members to stop arguing.', 0),
-- Options for QuestionID 87 (QuizID 9)
(87, 'Blame the team for falling behind.', 0),
(87, 'Extend the deadline without seeking solutions.', 0),
(87, 'Re-evaluate priorities, reallocate resources, and potentially work overtime.', 1),
(87, 'Give up on the project.', 0),
-- Options for QuestionID 89 (QuizID 9)
(89, 'Implementing a strict, top-down approach to project execution.', 0),
(89, 'Encouraging experimentation, psychological safety, and diverse ideas.', 1),
(89, 'Only rewarding individual achievements.', 0),
(89, 'Discouraging any form of failure or risk-taking.', 0),


-- Options for QuestionID 91 (QuizID 10: Workplace EQ Assessment)
(91, 'Always agreeing with colleagues to avoid conflict', 0),
(91, 'Understanding and sharing the feelings of another person', 1),
(91, 'Focusing solely on your own tasks and emotions', 0),
(91, 'Only showing emotions when you are angry or frustrated', 0),
-- Options for QuestionID 93 (QuizID 10)
(93, 'Being a good public speaker.', 0),
(93, 'Building rapport and navigating social situations effectively.', 1),
(93, 'Having a large network of contacts.', 0),
(93, 'Always being the center of attention.', 0),
-- Options for QuestionID 95 (QuizID 10)
(95, 'Self-awareness', 0),
(95, 'Relationship management', 1),
(95, 'Motivation', 0),
(95, 'Self-regulation', 0),
-- Options for QuestionID 97 (QuizID 10)
(97, 'Self-awareness', 0),
(97, 'Self-regulation', 0),
(97, 'Motivation (Resilience)', 1),
(97, 'Social skills', 0),
-- Options for QuestionID 99 (QuizID 10)
(99, 'Avoiding interactions with difficult colleagues.', 0),
(99, 'Resolving conflicts constructively and building positive networks.', 1),
(99, 'Only communicating through email.', 0),
(99, 'Micromanaging team members.', 0),


-- Options for QuestionID 101 (QuizID 11: Problem Solving Fundamentals Quiz)
(101, 'Identifying the best solution immediately', 0),
(101, 'Generating as many solutions as possible', 0),
(101, 'Finding the root cause of a problem', 1),
(101, 'Delegating the problem to someone else', 0),
-- Options for QuestionID 103 (QuizID 11)
(103, 'Brainstorming solutions', 0),
(103, 'Analyzing the problem and its root causes', 1),
(103, 'Implementing the solution', 0),
(103, 'Testing the solution', 0),
-- Options for QuestionID 105 (QuizID 11)
(105, 'Only the cost of the solution.', 0),
(105, 'Feasibility, cost, potential impact, and risks.', 1),
(105, 'How quickly it can be implemented, regardless of effectiveness.', 0),
(105, 'Only whether it''s a unique idea.', 0),
-- Options for QuestionID 107 (QuizID 11)
(107, 'Linear thinking', 0),
(107, 'Systematic approach', 0),
(107, 'Decomposition (breaking down)', 1),
(107, 'Analogical reasoning', 0),
-- Options for QuestionID 109 (QuizID 11)
(109, 'Jumping to conclusions without sufficient data.', 1),
(109, 'Thorough analysis of all aspects.', 0),
(109, 'Considering multiple perspectives.', 0),
(109, 'Systematic evaluation of solutions.', 0),


-- Options for QuestionID 111 (QuizID 12: Problem Definition Check)
(111, 'Brainstorming solutions', 0),
(111, 'Implementing a chosen solution', 0),
(111, 'Clearly defining the problem', 1),
(111, 'Collecting data', 0),
-- Options for QuestionID 112 (QuizID 12)
(112, 'A list of potential solutions.', 0),
(112, 'Only who is responsible for the problem.', 0),
(112, 'What the problem is, its impact, who is affected, and when/where it occurs.', 1),
(112, 'How the problem has been solved in the past.', 0),
-- Options for QuestionID 113 (QuizID 12)
(113, 'Because symptoms are easier to fix.', 0),
(113, 'Solving symptoms without addressing the root problem leads to recurrence.', 1),
(113, 'It is not important; just fix what you see.', 0),
(113, 'Symptoms are always more critical than the root problem.', 0),
-- Options for QuestionID 115 (QuizID 12)
(115, 'It has many possible interpretations.', 0),
(115, 'It is specific, measurable, achievable, relevant, and time-bound.', 1),
(115, 'It blames a specific individual or team.', 0),
(115, 'It only describes emotional feelings about the situation.', 0),
-- Options for QuestionID 117 (QuizID 12)
(117, 'Immediately start looking for external solutions.', 0),
(117, 'Validate it with data and input from affected parties.', 1),
(117, 'Keep it vague so everyone can interpret it differently.', 0),
(117, 'Assume you know all the details without asking.', 0),
-- Options for QuestionID 119 (QuizID 12)
(119, 'Pareto Chart', 0),
(119, 'Fishbone (Ishikawa) Diagram', 1),
(119, 'Control Chart', 0),
(119, 'Scatter Plot', 0);