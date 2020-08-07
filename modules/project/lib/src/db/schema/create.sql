CREATE TABLE IF NOT EXISTS "project"
(
    "project_id" SERIAL NOT NULL PRIMARY KEY,
    "title"      text,
    "from"       timestamptz,
    "to"         timestamptz
);

CREATE TABLE IF NOT EXISTS "task"
(
    "task_id"       SERIAL      NOT NULL PRIMARY KEY,
    "priority"      smallint    NOT NULL DEFAULT 0,
    "status"        smallint    NOT NULL DEFAULT 0,
    "parent_task"   integer,
    "title"         text        NOT NULL,
    "description"   text,
    "date_created"  timestamptz NOT NULL DEFAULT NOW(),
    "date_modified" timestamptz,
    "date_done"     timestamptz,
    "created_by"    integer     NOT NULL,
    "assigned_to"   integer     NOT NULL,
    "modified_by"   integer,
    "progress"      integer     NOT NULL DEFAULT 0,
    "deadline"      timestamptz NOT NULL DEFAULT NOW(),
    "project_id"    int         NOT NULL REFERENCES "project" (project_id) ON DELETE CASCADE,
    "is_deleted"    bool        NOT NULL DEFAULT FALSE,
    "tsv"           tsvector
);
CREATE INDEX "patient_tsv_idx" ON task USING gin ("tsv");
CREATE INDEX "task_assigned_to_idx" ON "task" ("assigned_to");
CREATE INDEX "task_created_by_idx" ON "task" ("created_by");
CREATE INDEX "task_modified_by_idx" ON "task" ("modified_by");
CREATE INDEX "task_project_id_idx" ON "task" ("project_id");

CREATE TABLE IF NOT EXISTS "task_comment"
(
    "task_comment_id" SERIAL      NOT NULL PRIMARY KEY,
    "task_id"         integer     NOT NULL REFERENCES "task" (task_id) ON DELETE CASCADE,
    "user_id"         integer     NOT NULL,
    "comment"         text        NOT NULL,
    "date_created"    timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "task_media"
(
    "task_media_id"   SERIAL      NOT NULL PRIMARY KEY,
    "task_id"         integer REFERENCES "task" (task_id) ON DELETE CASCADE,
    "task_comment_id" integer REFERENCES "task_comment" (task_comment_id) ON DELETE CASCADE,
    "source"          text,
    "date_created"    timestamptz NOT NULL DEFAULT NOW()
);
CREATE INDEX "task_media_task_id_idx" ON "task_media" ("task_id");

