ALTER TABLE task
    ADD CONSTRAINT task_user_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user" (user_id) ON DELETE CASCADE;
ALTER TABLE task
    ADD CONSTRAINT task_user_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES "user" (user_id) ON DELETE CASCADE;
ALTER TABLE task
    ADD CONSTRAINT task_user_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES "user" (user_id) ON DELETE CASCADE;

ALTER TABLE task_media
    ADD CONSTRAINT task_id_fkey FOREIGN KEY (task_id) REFERENCES "task" (task_id) ON DELETE CASCADE;

ALTER TABLE project
    ADD CONSTRAINT project_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES "user" (user_id) ON DELETE RESTRICT;

CREATE FUNCTION task_tsv_vector()
    RETURNS TRIGGER AS
$$
DECLARE

BEGIN
    NEW.tsv := to_tsvector(coalesce(new.title, ''))
        || to_tsvector(coalesce(new.description, ''));

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER task_tsv_vector
    BEFORE INSERT OR UPDATE
    ON task
    FOR EACH ROW
EXECUTE PROCEDURE task_tsv_vector();