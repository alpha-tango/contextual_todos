CREATE TABLE todos(
  id serial PRIMARY KEY,
  body varchar(255) NOT NULL,
  category varchar(255),
  complete boolean DEFAULT FALSE NOT NULL
);
