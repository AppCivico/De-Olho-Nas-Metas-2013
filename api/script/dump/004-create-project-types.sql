CREATE TABLE project_types ( id serial primary key , name text not null);

create table project_progress ( project_id integer references project(id) not null,milestone_id integer references project_types(id) not null, status integer not null, created_at timestamp default now(), updated_at timestamp);

alter table project drop column porcentage;
alter table project add column porcentage numeric;

alter table campaign add column region_id integer references region(id);

ALTER TABLE CAMPAIGN add column address text;
alter table campaign add column latitude text;
alter table campaign add column longitude text;
