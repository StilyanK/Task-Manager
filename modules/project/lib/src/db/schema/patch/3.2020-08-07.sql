alter table task add column tsv tsvector;

CREATE INDEX "patient_tsv_idx" ON task USING gin ("tsv");
CREATE INDEX "task_assigned_to_idx" ON "task" ("assigned_to");
CREATE INDEX "task_created_by_idx" ON "task" ("created_by");
CREATE INDEX "task_modified_by_idx" ON "task" ("modified_by");
CREATE INDEX "task_project_id_idx" ON "task" ("project_id");

CREATE INDEX "task_media_task_id_idx" ON "task_media" ("task_id");

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

update task set title = title;