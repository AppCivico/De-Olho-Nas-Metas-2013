-- Deploy flipr:0004-column-created_at to pg
-- requires: 0003-create-company-document

BEGIN;

alter table contact add column created_at timestamp default now();

COMMIT;
