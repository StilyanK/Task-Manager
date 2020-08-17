ALTER TABLE "task"
    ADD CONSTRAINT "parent_task_check" CHECK (parent_task != task_id);