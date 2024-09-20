# Проект управления задачами

## Описание

Проект представляет собой высокопроизводительное приложение для управления задачами, пользователями, проектами и интеграциями с внешними системами. Основные функции включают:
- Управление задачами и пользователями.
- Интеграция с Google Calendar для планирования созвонов.
- Система достижений с изображениями.
- ИИ-помощник для мониторинга задач и проектов.
- Треккинг времени на задачу, комментарии и возможность ставить задачи на паузу.

### 1. Архитектура

**Бэкенд**:
- Микросервисная архитектура (Go и C#).
- Redis — брокер сообщений для обмена событиями.
- RESTful API для взаимодействия между фронтендом и бэкендом.

**Фронтенд**:
- SPA (React/Vue/Angular).
- Взаимодействие с API для работы с задачами, проектами, пользователями и интеграцией с Google Calendar.

### 2. Основные модули приложения

1. **Микросервис "Пользователи" (C#)**:
    - Регистрация и авторизация пользователей.
    - Управление профилем пользователя (аватар, информация).
    - Связь с Google Calendar.

2. **Микросервис "Проекты и задачи" (Go)**:
    - CRUD операции для проектов и задач.
    - Поддержка статусов задач, трекинг времени и комментарии.
    - Поддержка статуса "на паузе" (on hold).

3. **Микросервис "Интеграция с Google Calendar" (C#)**:
    - Синхронизация с календарем.
    - Планирование созвонов на основе доступности пользователей.

4. **Микросервис "Уведомления и ИИ-помощник" (Go)**:
    - Отправка уведомлений о важных задачах.
    - Рекомендации по проектам на основе анализа данных.

5. **Микросервис "Достижения" (C#)**:
    - Система достижений с изображениями.
    - Управление пользовательскими ачивками.

---

### 3. Структура базы данных

#### Таблица `users`
- `id` (UUID) — уникальный идентификатор.
- `name` (string) — имя пользователя.
- `email` (string) — электронная почта.
- `password_hash` (string) — хэш пароля.
- `avatar_url` (string) — URL аватара пользователя.
- `google_calendar_token` (string) — токен для интеграции с Google Calendar.
- `created_at` (timestamp).
- `updated_at` (timestamp).

#### Таблица `projects`
- `id` (UUID) — уникальный идентификатор проекта.
- `name` (string) — название проекта.
- `description` (text) — описание проекта.
- `created_by` (UUID, references `users`) — автор проекта.
- `created_at` (timestamp).
- `updated_at` (timestamp).

#### Таблица `tasks`
- `id` (UUID) — уникальный идентификатор задачи.
- `project_id` (UUID, references `projects`) — проект, к которому относится задача.
- `title` (string) — заголовок задачи.
- `description` (text) — описание задачи.
- `assigned_to` (UUID, references `users`) — пользователь, назначенный на задачу.
- `status` (string: "open", "in progress", "completed", "on hold") — статус задачи.
- `priority` (string: "minor", "major", "critical", "blocker") — приоритет задачи.
- `due_date` (timestamp) — срок выполнения задачи.
- `time_spent` (integer) — затраченное время в минутах.
- `comments` (JSONB) — комментарии (автор, текст, timestamp).
- `created_at` (timestamp).
- `updated_at` (timestamp).

#### Таблица `achievements`
- `id` (UUID) — уникальный идентификатор достижения.
- `user_id` (UUID, references `users`) — пользователь, получивший достижение.
- `achievement_type` (string) — тип достижения.
- `image_url` (string) — URL изображения достижения.
- `created_at` (timestamp).

#### Таблица `calendar_events`
- `id` (UUID) — уникальный идентификатор события.
- `task_id` (UUID, references `tasks`) — задача, связанная с событием.
- `event_start` (timestamp) — время начала события.
- `event_end` (timestamp) — время окончания события.
- `event_url` (string) - ссылка на проводимое событие
- `google_event_id` (string) — идентификатор события в Google Calendar.

#### Таблица `project_users` (многие ко многим)
- `project_id` (UUID, references `projects`) — проект.
- `user_id` (UUID, references `users`) — пользователь.

---

### 4. Примеры запросов

#### 1. **Регистрация пользователя**

**POST /users/register**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Ответ**:
```json
{
  "id": "a1b2c3d4",
  "name": "John Doe",
  "email": "john@example.com",
  "avatar_url": null,
  "created_at": "2024-09-17T10:00:00Z"
}
```

#### 2. **Загрузка аватара пользователя**

**POST /users/upload-avatar**
```json
{
  "user_id": "a1b2c3d4",
  "avatar_url": "https://example.com/avatars/user123.png"
}
```

**Ответ**:
```json
{
  "message": "Avatar updated successfully"
}
```

#### 3. **Создание проекта**

**POST /projects**
```json
{
  "name": "New Project",
  "description": "This is a new project",
  "created_by": "a1b2c3d4"
}
```

**Ответ**:
```json
{
  "id": "p1q2w3e4",
  "name": "New Project",
  "description": "This is a new project",
  "created_by": "a1b2c3d4",
  "created_at": "2024-09-17T10:00:00Z"
}
```

#### 4. **Создание задачи с трекингом времени и комментариями**

**POST /tasks**
```json
{
  "project_id": "p1q2w3e4",
  "title": "Task 1",
  "description": "Description of the task",
  "assigned_to": "b2c3d4e5",
  "status": "in progress",
  "due_date": "2024-09-20T15:00:00Z",
  "time_spent": 120,
  "comments": [
    {
      "author": "a1b2c3d4",
      "text": "Initial comment",
      "timestamp": "2024-09-17T10:05:00Z"
    }
  ]
}
```

**Ответ**:
```json
{
  "id": "t1y2u3i4",
  "project_id": "p1q2w3e4",
  "title": "Task 1",
  "description": "Description of the task",
  "assigned_to": "b2c3d4e5",
  "status": "in progress",
  "time_spent": 120,
  "comments": [
    {
      "author": "a1b2c3d4",
      "text": "Initial comment",
      "timestamp": "2024-09-17T10:05:00Z"
    }
  ],
  "created_at": "2024-09-17T10:00:00Z"
}
```

#### 5. **Добавление комментария к задаче**

**POST /tasks/:id/comments**
```json
{
  "author": "b2c3d4e5",
  "text": "Additional comment",
  "timestamp": "2024-09-17T11:00:00Z"
}
```

**Ответ**:
```json
{
  "message": "Comment added successfully"
}
```

#### 6. **Создание достижения с картинкой**

**POST /achievements**
```json
{
  "user_id": "a1b2c3d4",
  "achievement_type": "Completed 10 tasks",
  "image_url": "https://example.com/images/achievement1.png"
}
```

**Ответ**:
```json
{
  "id": "ach1",
  "user_id": "a1b2c3d4",
  "achievement_type": "Completed 10 tasks",
  "image_url": "https://example.com/images/achievement1.png",
  "created_at": "2024-09-17T10:00:00Z"
}
```

#### 7. **Выход из учетной записи**

**POST /users/logout**
```json
{
  "user_id": "a1b2c3d4"
}
```

**Ответ**:
```json
{
  "message": "User logged out successfully"
}
```

#### 8. **Получение списка проектов пользователя**



**GET /users/:id/projects**
```json
{
  "user_id": "a1b2c3d4"
}
```

**Ответ**:
```json
[
  {
    "id": "p1q2w3e4",
    "name": "New Project",
    "description": "This is a new project",
    "created_at": "2024-09-17T10:00:00Z"
  },
  {
    "id": "r5t6y7u8",
    "name": "Second Project",
    "description": "This is another project",
    "created_at": "2024-09-16T09:00:00Z"
  }
]
```

#### 9. **Синхронизация событий с Google Calendar**

**POST /calendar/sync**
```json
{
  "user_id": "a1b2c3d4",
  "google_calendar_token": "ya29.A0ARrdaM..."
}
```

**Ответ**:
```json
{
  "message": "Calendar synchronized successfully",
  "synced_events": [
    {
      "id": "event1",
      "task_id": "t1y2u3i4",
      "event_start": "2024-09-18T09:00:00Z",
      "event_end": "2024-09-18T10:00:00Z",
      "google_event_id": "abc123"
    },
    {
      "id": "event2",
      "task_id": "t5r6u7v8",
      "event_start": "2024-09-19T14:00:00Z",
      "event_end": "2024-09-19T15:00:00Z",
      "google_event_id": "def456"
    }
  ]
}
```

---

### 5. Страница пользователя

На странице профиля пользователь сможет:
- Загрузить аватар (см. запрос 2).
- Просмотреть список проектов (см. запрос 8).
- Синхронизировать события с Google Calendar (см. запрос 9).
- Просмотреть свои достижения с изображениями.

#### Пример достижения

```json
{
  "id": "ach1",
  "achievement_type": "Completed 10 tasks",
  "image_url": "https://example.com/images/achievement1.png",
  "created_at": "2024-09-17T10:00:00Z"
}
```

#### Достижения на странице пользователя

```json
[
  {
    "id": "ach1",
    "achievement_type": "Completed 10 tasks",
    "image_url": "https://example.com/images/achievement1.png",
    "created_at": "2024-09-17T10:00:00Z"
  },
  {
    "id": "ach2",
    "achievement_type": "Completed 5 projects",
    "image_url": "https://example.com/images/achievement2.png",
    "created_at": "2024-09-16T12:00:00Z"
  }
]
```

---