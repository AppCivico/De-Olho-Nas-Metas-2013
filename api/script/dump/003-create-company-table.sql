CREATE TABLE company ( id serial primary key, name text not null, name_url text not null, goal_id integer references goal(id));

alter table budget add column company_id integer references company(id);
