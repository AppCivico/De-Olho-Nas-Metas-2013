alter table goal drop state_id;
alter table goal drop city_id;
alter table goal drop district_id;
alter table goal drop lat_lng;
alter table goal drop status_id;
alter table goal rename column porcentage to percentage;
