create table register_counsil_manual ( id serial primary key , email text not null, phone_number text not null, council text not null, name text not null);

create table milestones (id serial primary key, name text  not null, project_type_id integer references project_types(id), percentage integer, sequence integer );

create table project_milestones ( id serial primary key, project_id integer references project(id), milestone integer references milestones(id), status integer, created_at timestamp default now(), updated_at timestamp);

alter table project rename porcentage to percentage;
alter table project add column type integer references project_types(id)

alter table campaign add column organization_id integer references organization(id)

