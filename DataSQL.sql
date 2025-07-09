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
INSERT INTO SliderImage (SliderID,CourseID, SliderTitle, SliderContent, SliderURL, Status)
VALUES
(1,4, 'Boost Your Confidence in Public Speaking', 'Learn practical tips and techniques to overcome stage fright and speak clearly.', 'media/sliders/image1.png', 1),
(2,2, 'Master Time Management Today', 'Prioritize what matters and reclaim your hours with proven time strategies.', 'media/sliders/image2.png', 1),
(3,6, 'Enhance Your EQ for Workplace Success', 'Emotional intelligence improves teamwork, communication, and leadership.', 'media/sliders/image3.png', 0),
(4,7, 'Become a Pro at Problem Solving', 'Tackle complex problems with confidence using structured problem-solving tools.', 'media/sliders/image4.png', 1);




INSERT INTO Chapter (CourseID, Title, ChapterOrder) VALUES
-- Chapters for 'Strategic Leadership' (CourseID 1)
(1, 'Foundations of Strategic Leadership', 1),
(1, 'Developing Vision and Strategy', 2),
(1, 'Executing and Adapting Strategy', 3),

-- Chapters for 'Time Management Mastery' (CourseID 2)
(2, 'Understanding Time and Priorities', 1),
(2, 'Effective Planning and Techniques', 2),
(2, 'Overcoming Obstacles to Productivity', 3),

-- Chapters for 'Mastering Self-Awareness' (CourseID 3)
(3, 'Basics of Self-Awareness', 1),
(3, 'Developing Internal Awareness', 2),
(3, 'Applying Self-Awareness in Life', 3),

-- Chapters for 'Public Speaking Essentials' (CourseID 4)
(4, 'Preparation and Audience Analysis', 1),
(4, 'Structuring and Delivering Your Message', 2),
(4, 'Handling Nerves and Engaging Audience', 3),

-- Chapters for 'Leadership Fundamentals' (CourseID 5)
(5, 'The Essence of Leadership', 1),
(5, 'Key Leadership Skills', 2),
(5, 'Building and Inspiring Your Team', 3),
(5, 'Leading Through Challenges', 4),

-- Chapters for 'Emotional Intelligence at Work' (CourseID 6)
(6, 'Introduction to Emotional Intelligence', 1),
(6, 'Self-Management and Awareness', 2),
(6, 'Social Awareness and Relationship Management', 3),

-- Chapters for 'Problem Solving Techniques' (CourseID 7)
(7, 'Defining and Analyzing Problems', 1),
(7, 'Generating and Evaluating Solutions', 2),
(7, 'Implementing and Reviewing Solutions', 3),

-- Chapters for 'Critical Thinking Skills' (CourseID 8)
(8, 'Foundations of Critical Thinking', 1),
(8, 'Analyzing Arguments and Evidence', 2),
(8, 'Making Informed Decisions', 3),

-- Chapters for 'Effective Communication Skills' (CourseID 9)
(9, 'Fundamentals of Communication', 1),
(9, 'Verbal and Non-Verbal Communication', 2),
(9, 'Listening and Feedback Skills', 3),
(9, 'Advanced Communication Strategies', 4),

-- Chapters for 'Productivity & Planning Bootcamp' (CourseID 10)
(10, 'Understanding Productivity Basics', 1),
(10, 'Goal Setting and Prioritization', 2),
(10, 'Advanced Planning and Execution', 3);



INSERT INTO Lesson (ChapterID, Title, IsFree, LessonOrder, Status) VALUES
-- Lessons for 'Foundations of Strategic Leadership' (ChapterID 1, CourseID 1)
(1, 'Welcome to Strategic Leadership', 1, 1, 1),
(1, 'The Importance of Strategic Thinking', 0, 2, 1),
(1, 'Key Concepts of Strategic Leadership', 0, 3, 1),

-- Lessons for 'Developing Vision and Strategy' (ChapterID 2, CourseID 1)
(2, 'Crafting a Compelling Vision', 0, 1, 1),
(2, 'Strategic Goal Setting', 0, 2, 1),
(2, 'SWOT Analysis for Leaders', 0, 3, 1),
(2, 'Developing Strategic Initiatives', 0, 4, 1),

-- Lessons for 'Executing and Adapting Strategy' (ChapterID 3, CourseID 1)
(3, 'Aligning Teams with Strategy', 0, 1, 1),
(3, 'Monitoring and Evaluation', 0, 2, 1),
(3, 'Adapting to Market Changes', 0, 3, 1),

-- Lessons for 'Understanding Time and Priorities' (ChapterID 4, CourseID 2)
(4, 'Introduction to Time Management', 1, 1, 1),
(4, 'Identifying Your Time Wasters', 0, 2, 1),
(4, 'The Power of Prioritization', 0, 3, 1),

-- Lessons for 'Effective Planning and Techniques' (ChapterID 5, CourseID 2)
(5, 'Setting Effective Goals (SMART)', 0, 1, 1),
(5, 'Time Blocking and Scheduling', 0, 2, 1),
(5, 'The Pomodoro Technique Explained', 0, 3, 1),
(5, 'Creating Effective To-Do Lists', 0, 4, 1),

-- Lessons for 'Overcoming Obstacles to Productivity' (ChapterID 6, CourseID 2)
(6, 'Dealing with Distractions', 0, 1, 1),
(6, 'Overcoming Procrastination', 0, 2, 1),
(6, 'Delegation Skills', 0, 3, 1),

-- Lessons for 'Basics of Self-Awareness' (ChapterID 7, CourseID 3)
(7, 'What is Self-Awareness and Why it Matters?', 1, 1, 1),
(7, 'Internal vs. External Self-Awareness', 0, 2, 1),

-- Lessons for 'Developing Internal Awareness' (ChapterID 8, CourseID 3)
(8, 'Journaling for Self-Discovery', 0, 1, 1),
(8, 'Mindfulness Practices for Awareness', 0, 2, 1),
(8, 'Understanding Your Values and Beliefs', 0, 3, 1),

-- Lessons for 'Applying Self-Awareness in Life' (ChapterID 9, CourseID 3)
(9, 'Seeking and Receiving Feedback Effectively', 0, 1, 1),
(9, 'Managing Your Emotions with Awareness', 0, 2, 1),

-- Lessons for 'Preparation and Audience Analysis' (ChapterID 10, CourseID 4)
(10, 'Understanding Your Audience', 1, 1, 1),
(10, 'Defining Your Message and Purpose', 0, 2, 1),
(10, 'Structuring Your Presentation', 0, 3, 1),

-- Lessons for 'Structuring and Delivering Your Message' (ChapterID 11, CourseID 4)
(11, 'Crafting Engaging Introductions and Conclusions', 0, 1, 1),
(11, 'Using Visual Aids Effectively', 0, 2, 1),
(11, 'Vocal Delivery and Body Language', 0, 3, 1),

-- Lessons for 'Handling Nerves and Engaging Audience' (ChapterID 12, CourseID 4)
(12, 'Managing Public Speaking Anxiety', 0, 1, 1),
(12, 'Techniques for Audience Engagement', 0, 2, 1),

-- Lessons for 'The Essence of Leadership' (ChapterID 13, CourseID 5)
(13, 'What Defines a Leader?', 1, 1, 1),
(13, 'Leadership Styles and Their Impact', 0, 2, 1),

-- Lessons for 'Key Leadership Skills' (ChapterID 14, CourseID 5)
(14, 'Effective Communication for Leaders', 0, 1, 1),
(14, 'Decision Making in Leadership', 0, 2, 1),
(14, 'Delegation and Empowerment', 0, 3, 1),

-- Lessons for 'Building and Inspiring Your Team' (ChapterID 15, CourseID 5)
(15, 'Motivating and Inspiring Your Team', 0, 1, 1),
(15, 'Conflict Resolution in Teams', 0, 2, 1),

-- Lessons for 'Leading Through Challenges' (ChapterID 16, CourseID 5)
(16, 'Leading Through Change', 0, 1, 1),
(16, 'Resilience in Leadership', 0, 2, 1),

-- Lessons for 'Introduction to Emotional Intelligence' (ChapterID 17, CourseID 6)
(17, 'Understanding Emotional Intelligence (EQ)', 1, 1, 1),
(17, 'Why EQ Matters in the Workplace', 0, 2, 1),

-- Lessons for 'Self-Management and Awareness' (ChapterID 18, CourseID 6)
(18, 'Developing Self-Awareness at Work', 0, 1, 1),
(18, 'Strategies for Self-Regulation', 0, 2, 1),

-- Lessons for 'Social Awareness and Relationship Management' (ChapterID 19, CourseID 6)
(19, 'Practicing Empathy in Professional Settings', 0, 1, 1),
(19, 'Building Strong Work Relationships', 0, 2, 1),

-- Lessons for 'Defining and Analyzing Problems' (ChapterID 20, CourseID 7)
(20, 'Introduction to Problem Solving', 1, 1, 1),
(20, 'Defining the Problem Clearly', 0, 2, 1),
(20, 'Root Cause Analysis (5 Whys)', 0, 3, 1),

-- Lessons for 'Generating and Evaluating Solutions' (ChapterID 21, CourseID 7)
(21, 'Brainstorming Techniques', 0, 1, 1),
(21, 'Evaluating Potential Solutions', 0, 2, 1),

-- Lessons for 'Implementing and Reviewing Solutions' (ChapterID 22, CourseID 7)
(22, 'Action Planning and Implementation', 0, 1, 1),
(22, 'Monitoring and Adapting Solutions', 0, 2, 1),

-- Lessons for 'Foundations of Critical Thinking' (ChapterID 23, CourseID 8)
(23, 'What is Critical Thinking?', 1, 1, 1),
(23, 'The Importance of Objective Analysis', 0, 2, 1),

-- Lessons for 'Analyzing Arguments and Evidence' (ChapterID 24, CourseID 8)
(24, 'Identifying Arguments and Premises', 0, 1, 1),
(24, 'Evaluating Evidence and Sources', 0, 2, 1),

-- Lessons for 'Making Informed Decisions' (ChapterID 25, CourseID 8)
(25, 'Recognizing Cognitive Biases', 0, 1, 1),
(25, 'Applying Critical Thinking to Decision Making', 0, 2, 1),

-- Lessons for 'Fundamentals of Communication' (ChapterID 26, CourseID 9)
(26, 'The Communication Process', 1, 1, 1),
(26, 'Barriers to Effective Communication', 0, 2, 1),

-- Lessons for 'Verbal and Non-Verbal Communication' (ChapterID 27, CourseID 9)
(27, 'Mastering Verbal Communication', 0, 1, 1),
(27, 'Understanding Non-Verbal Cues', 0, 2, 1),

-- Lessons for 'Listening and Feedback Skills' (ChapterID 28, CourseID 9)
(28, 'Active Listening Techniques', 0, 1, 1),
(28, 'Giving and Receiving Constructive Feedback', 0, 2, 1),

-- Lessons for 'Advanced Communication Strategies' (ChapterID 29, CourseID 9)
(29, 'Communication in Difficult Conversations', 0, 1, 1),
(29, 'Cross-Cultural Communication', 0, 2, 1),

-- Lessons for 'Understanding Productivity Basics' (ChapterID 30, CourseID 10)
(30, 'What is True Productivity?', 1, 1, 1),
(30, 'Identifying Your Productivity Style', 0, 2, 1),

-- Lessons for 'Goal Setting and Prioritization' (ChapterID 31, CourseID 10)
(31, 'Setting Meaningful Goals', 0, 1, 1),
(31, 'Prioritization Frameworks (Urgent/Important)', 0, 2, 1),

-- Lessons for 'Advanced Planning and Execution' (ChapterID 32, CourseID 10)
(32, 'Advanced Time Blocking', 0, 1, 1),
(32, 'Batching and Deep Work', 0, 2, 1),
(32, 'Reviewing Your Productivity', 0, 3, 1);



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