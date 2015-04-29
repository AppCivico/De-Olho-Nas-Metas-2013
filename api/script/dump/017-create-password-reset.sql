create table password_reset 
    ( id serial primary key , 
      user_id integer references "user"(id), 
      hash text not null,
      expires_at timestamp default (now() + interval '7 days'),
      valid boolean default true,
      created_at timestamp default now() 
    );
