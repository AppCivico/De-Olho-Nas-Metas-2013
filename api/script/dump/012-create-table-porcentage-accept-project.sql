create table project_accept_porcentage (id serial not null, project_id integer references project(id) not null, user_id integer references "user"(id), accepted boolean not null, created_at timestamp default now())
;

