alter table project_accept_porcentage drop column accepted;
create type project_progress_type as enum ('late','in_progress' , 'completed');
alter table project_accept_porcentage add column progress project_progress_type;
alter table project add column goal_id integer references goal(id);


