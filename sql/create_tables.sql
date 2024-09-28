-- Creation of users table
CREATE TABLE IF NOT EXISTS users (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    email varchar(100) NOT NULL UNIQUE,
    password_hash varchar(450) NOT NULL,
    avatar_url varchar(450),
    google_calendar_token varchar(450),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP
);

-- Creation of projects table
CREATE TABLE IF NOT EXISTS projects (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    code varchar(100) NOT NULL,
    description varchar(500),
    created_by integer NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP,
    CONSTRAINT fk_creator
        FOREIGN KEY(created_by)
            REFERENCES users(id)
                ON DELETE CASCADE
);

-- Creation of tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id serial PRIMARY KEY,
    task_id varchar(100) NOT NULL,
    project_id integer NOT NULL,
    title varchar(100) NOT NULL,
    description varchar(500),
    assigned_to integer NOT NULL,
    status varchar(50) NOT NULL,
    priority varchar(50) NOT NULL,
    due_date TIMESTAMP,
    time_spent integer NOT NULL,
    comments JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP,
    CONSTRAINT fk_project_id
        FOREIGN KEY(project_id)
            REFERENCES projects(id)
            ON DELETE CASCADE,
    CONSTRAINT fk_assigned_to
        FOREIGN KEY(assigned_to)
            REFERENCES users(id)
                ON DELETE SET NULL
);

-- Creation of achievements table
CREATE TABLE IF NOT EXISTS achievements (
    id serial PRIMARY KEY,
    user_id integer NOT NULL,
    achievement_type varchar(150) NOT NULL,
    image_url varchar(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_achivement
        FOREIGN KEY(user_id)
            REFERENCES users(id)
                ON DELETE CASCADE
);

-- Creation of calendar_events table
CREATE TABLE IF NOT EXISTS calendar_events (
    id serial PRIMARY KEY,
    task_id integer NOT NULL,
    event_start TIMESTAMP NOT NULL,
    event_end TIMESTAMP NOT NULL,
    event_url varchar(150),
    google_event_id varchar(100),
    CONSTRAINT fk_event
        FOREIGN KEY(task_id)
            REFERENCES tasks(id)
                ON DELETE CASCADE
);

-- Creation of project_users table
CREATE TABLE IF NOT EXISTS project_users (
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT fk_pu_project
        FOREIGN KEY(project_id)
            REFERENCES projects(id)
                ON DELETE CASCADE,
    CONSTRAINT fk_pu_user
        FOREIGN KEY(user_id)
            REFERENCES users(id)
                ON DELETE CASCADE
);