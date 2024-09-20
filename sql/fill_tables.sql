-- Insert users
INSERT INTO users (name, email, password_hash, avatar_url)
VALUES
    ('John Doe', 'john@example.com', 'hashed_password_1', 'https://example.com/avatar1.png'),
    ('Jane Smith', 'jane@example.com', 'hashed_password_2', 'https://example.com/avatar2.png'),
    ('Mike Johnson', 'mike@example.com', 'hashed_password_3', 'https://example.com/avatar3.png'),
    ('Anna Davis', 'anna@example.com', 'hashed_password_4', 'https://example.com/avatar4.png');

-- Insert project
INSERT INTO projects (name, description, created_by)
VALUES
    ('Hackathon Project', 'High-performance project management app', 1);

-- Insert tasks
INSERT INTO tasks (project_id, title, description, assigned_to, status, priority, due_date, time_spent, comments)
VALUES
    (1, 'Set up project structure', 'Initialize project structure and tools', 1, 'completed', 'critical', '2024-09-25 10:00:00', 240, '[{"author": "John Doe", "text": "Initial setup done", "timestamp": "2024-09-19T09:00:00Z"}]'),
    (1, 'Database schema design', 'Design and create database schema', 2, 'in progress', 'major', '2024-09-26 15:00:00', 180, '[{"author": "Jane Smith", "text": "Working on schema", "timestamp": "2024-09-19T12:00:00Z"}]'),
    (1, 'Frontend layout', 'Create the basic frontend layout', 3, 'open', 'major', '2024-09-27 12:00:00', 0, '[]'),
    (1, 'API for users', 'Create the API for user registration and authentication', 1, 'in progress', 'blocker', '2024-09-28 18:00:00', 120, '[{"author": "John Doe", "text": "Started working on it", "timestamp": "2024-09-20T10:00:00Z"}]'),
    (1, 'Google Calendar integration', 'Add Google Calendar integration for scheduling', 2, 'open', 'critical', '2024-09-29 09:00:00', 0, '[]'),
    (1, 'AI assistant module', 'Implement AI assistant for task management', 4, 'open', 'minor', '2024-09-30 16:00:00', 0, '[]'),
    (1, 'User achievements', 'Create system for user achievements', 3, 'open', 'major', '2024-10-01 14:00:00', 0, '[]'),
    (1, 'Notifications service', 'Develop service for notifications and reminders', 4, 'on hold', 'minor', '2024-10-02 11:00:00', 60, '[{"author": "Anna Davis", "text": "Paused until API is ready", "timestamp": "2024-09-21T15:00:00Z"}]'),
    (1, 'Task time tracking', 'Add time tracking for tasks', 2, 'in progress', 'major', '2024-10-03 13:00:00', 90, '[{"author": "Jane Smith", "text": "Almost done", "timestamp": "2024-09-22T09:00:00Z"}]'),
    (1, 'Finalize project documentation', 'Complete project documentation', 1, 'open', 'blocker', '2024-10-04 17:00:00', 0, '[]');

-- Insert achievements
INSERT INTO achievements (user_id, achievement_type, image_url)
VALUES
    (1, 'Completed 5 tasks', 'https://example.com/achievement1.png'),
    (2, 'Added Google Calendar integration', 'https://example.com/achievement2.png'),
    (3, 'Designed project structure', 'https://example.com/achievement3.png'),
    (4, 'Implemented notification system', 'https://example.com/achievement4.png'),
    (1, 'Finalized API structure', 'https://example.com/achievement5.png');

-- Insert calendar events
INSERT INTO calendar_events (task_id, event_start, event_end, event_url, google_event_id)
VALUES
    (2, '2024-09-23 10:00:00', '2024-09-23 11:00:00', 'https://meet.google.com/event1', 'event_abc123'),
    (4, '2024-09-24 14:00:00', '2024-09-24 15:00:00', 'https://meet.google.com/event2', 'event_def456'),
    (5, '2024-09-25 09:00:00', '2024-09-25 10:00:00', 'https://meet.google.com/event3', 'event_ghi789');
