create table file (id serial primary key not null, name text , status_text json, created_at timestamp default now(), created_by integer references "user"(id));
