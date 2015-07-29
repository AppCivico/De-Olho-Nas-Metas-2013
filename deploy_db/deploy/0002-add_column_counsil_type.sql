-- Deploy flipr:0002-add_column_counsil_type to pg
-- requires: 0001-donmschema

BEGIN;

create table organization_type ( id serial primary key, name text );

alter table organization add column organization_type_id integer references organization_type(id);

COMMIT;

