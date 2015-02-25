ALTER TABLE project_event ADD COLUMN is_last boolean default true;

ALTER TABLE project_event ADD UNIQUE (project_id, is_last);
ALTER TABLE project_event ADD CHECK (is_last != false);

