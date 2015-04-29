create type user_request_type as enum ('pending', 'denied', 'accepted');
create table user_request_council ( 
    id serial primary key , 
    user_id integer references "user"(id) not null, 
    organization_id integer references organization(id) not null, 
    user_status user_request_type not null, 
    created_at timestamp default now());
