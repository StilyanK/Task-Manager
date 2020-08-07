ALTER TABLE task
    ADD CONSTRAINT task_user_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user" (user_id) ON DELETE CASCADE;
ALTER TABLE task
    ADD CONSTRAINT task_user_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES "user" (user_id) ON DELETE CASCADE;
ALTER TABLE task
    ADD CONSTRAINT task_user_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES "user" (user_id) ON DELETE CASCADE;

ALTER TABLE task_media
    ADD CONSTRAINT task_id_fkey FOREIGN KEY (task_id) REFERENCES "task" (task_id) ON DELETE CASCADE;
