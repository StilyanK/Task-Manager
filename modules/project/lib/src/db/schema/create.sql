CREATE TABLE IF NOT EXISTS "task"
(
    "task_id"       SERIAL      NOT NULL PRIMARY KEY,
    "priority"      smallint    NOT NULL DEFAULT 0,
    "status"        smallint    NOT NULL DEFAULT 0,
    "parent_task"   integer,
    "title"         text        NOT NULL,
    "description"   text,
    "date_created"  timestamptz NOT NULL DEFAULT NOW(),
    "date_modified" timestamptz NOT NULL DEFAULT NOW(),
    "created_by"    integer     NOT NULL,
    "assigned_to"   integer     NOT NULL,
    "modified_by"   integer
);

CREATE TABLE IF NOT EXISTS "task_comment"
(
    "task_comment" SERIAL      NOT NULL PRIMARY KEY,
    "task_id"      integer     NOT NULL,
    "user_id"      integer     NOT NULL,
    "comment"      text        NOT NULL,
    "date_created" timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "task_media"
(
    "task_media_id"   SERIAL      NOT NULL PRIMARY KEY,
    "task_id"         integer,
    "task_comment_id" integer,
    "source"          text,
    "date_created"    timestamptz NOT NULL DEFAULT NOW()
);