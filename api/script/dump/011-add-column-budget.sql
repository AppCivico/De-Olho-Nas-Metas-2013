alter table budget add column cod_emp text;

alter table budget  add column updated_at timestamp;

alter table budget  add column created_at timestamp default now();
