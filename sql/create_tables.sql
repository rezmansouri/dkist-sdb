CREATE TABLE granule_with_dot (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP,
  shape GEOMETRY(Polygon, 4326)
);

CREATE TABLE granule_with_lane (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP,
  shape GEOMETRY(Polygon, 4326)
);

CREATE TABLE uniform_granule (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP,
  shape GEOMETRY(Polygon, 4326)
);

CREATE TABLE complex_granule (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP,
  shape GEOMETRY(Polygon, 4326)
);

CREATE TABLE intergranular_lane (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP,
  shape GEOMETRY(Polygon, 4326)
);