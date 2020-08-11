CREATE TABLE IF NOT EXISTS "user_group"
(
    "user_group_id" smallserial  NOT NULL PRIMARY KEY,
    "name"          varchar(100) NOT NULL,
    "permissions"   jsonb
);

CREATE TABLE IF NOT EXISTS "user"
(
    "user_id"       smallserial  NOT NULL PRIMARY KEY,
    "user_group_id" smallint     NOT NULL REFERENCES "user_group" ON DELETE RESTRICT,
    "username"      varchar(100) NOT NULL UNIQUE,
    "password"      varchar(60),
    "name"          varchar(100),
    "mail"          varchar(100),
    "active"        bool         NOT NULL DEFAULT false,
    "picture"       varchar(100),
    "settings"      jsonb        NOT NULL,
    "hidden"        bool         NOT NULL DEFAULT false,
    "date_created"  timestamptz  NOT NULL DEFAULT NOW(),
    "date_modified" timestamptz  NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "user_session"
(
    "user_id"    smallint    NOT NULL REFERENCES "user" ON DELETE CASCADE,
    "session"    varchar(32) NOT NULL,
    "date_start" timestamptz NOT NULL,
    "date_end"   timestamptz NULL,
    "data"       jsonb       NOT NULL,
    PRIMARY KEY ("user_id", "session")
);
CREATE INDEX ON "user_session" ("session");

CREATE TABLE IF NOT EXISTS "user_notification"
(
    "user_notification_id" serial   NOT NULL PRIMARY KEY,
    "user_id"              smallint NOT NULL REFERENCES "user" ON DELETE CASCADE,
    "notification_id"      int,
    "read"                 bool     NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS "user_event"
(
    "id"            serial       NOT NULL PRIMARY KEY,
    "user_id"       smallint     NOT NULL REFERENCES "user" ON DELETE CASCADE,
    "parent_id"     integer,
    "type"          smallint     NOT NULL DEFAULT 1,
    "title"         varchar(100) NOT NULL,
    "description"   text,
    "date_start"    timestamptz,
    "date_end"      timestamptz,
    "all_day"       bool         NOT NULL DEFAULT FALSE,
    "recurring"     jsonb,
    "date_created"  timestamptz  NOT NULL DEFAULT NOW(),
    "date_modified" timestamptz  NOT NULL DEFAULT NOW()
);

CREATE FUNCTION user_event_lastmodified_column()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.date_modified = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_event_lastmodified
    BEFORE UPDATE
    ON user_event
    FOR EACH ROW
EXECUTE PROCEDURE
    user_event_lastmodified_column();

CREATE TABLE IF NOT EXISTS "chat_room"
(
    "chat_room_id" serial PRIMARY KEY,
    "name"         text,
    "context"      text UNIQUE
);
CREATE INDEX ON "chat_room" ("context");

CREATE TABLE IF NOT EXISTS "chat_message"
(
    "chat_message_id" bigserial PRIMARY KEY,
    "chat_room_id"    integer     NOT NULL REFERENCES "chat_room" ("chat_room_id") ON DELETE RESTRICT,
    "user_id"         integer     NOT NULL REFERENCES "user" ("user_id") ON DELETE RESTRICT,
    "timestamp"       timestamptz NOT NULL DEFAULT now(),
    "content"         text,
    "type"            integer
);
CREATE INDEX ON "chat_message" ("user_id");
CREATE INDEX ON "chat_message" ("timestamp");

CREATE TABLE IF NOT EXISTS "chat_attachment"
(
    "chat_attachment_id" serial PRIMARY KEY,
    "chat_message_id"    integer NOT NULL REFERENCES "chat_message" ("chat_message_id") ON DELETE RESTRICT,
    "source"             text    NOT NULL,
    "name"               text
);
CREATE INDEX ON "chat_attachment" ("chat_message_id");

CREATE TABLE IF NOT EXISTS "chat_membership"
(
    "chat_membership_id"   serial PRIMARY KEY,
    "chat_room_id"         integer     NOT NULL REFERENCES "chat_room" ("chat_room_id") ON DELETE RESTRICT,
    "user_id"              integer     NOT NULL REFERENCES "user" ("user_id") ON DELETE RESTRICT,
    "timestamp_join"       timestamptz NOT NULL DEFAULT NOW(),
    "timestamp_leave"      timestamptz,
    "chat_message_seen_id" integer,
    UNIQUE (chat_room_id, user_id)
);
CREATE INDEX ON "chat_membership" ("chat_room_id");
CREATE INDEX ON "chat_membership" ("user_id");