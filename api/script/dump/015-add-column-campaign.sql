 alter table campaign add column mobile_campaign_id integer;
 alter table campaign add column project_id integer references project(id);


