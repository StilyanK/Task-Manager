alter table project add column manager_id integer;
alter table project add column picture text;

ALTER TABLE project
    ADD CONSTRAINT project_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES "user" (user_id) ON DELETE RESTRICT;
