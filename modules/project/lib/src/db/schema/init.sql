ALTER TABLE task
    ADD CONSTRAINT task_user_created_by FOREIGN KEY (created_by) REFERENCES "user" (user_id) ON DELETE CASCADE;
ALTER TABLE task
    ADD CONSTRAINT task_user_assigned_to FOREIGN KEY (assigned_to) REFERENCES "user" (user_id) ON DELETE CASCADE;
ALTER TABLE task
    ADD CONSTRAINT task_user_modified_by FOREIGN KEY (modified_by) REFERENCES "user" (user_id) ON DELETE CASCADE;