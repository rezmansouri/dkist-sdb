CREATE TABLE intergranular_lane (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP not null,
  tracked_id int,
  shape GEOMETRY(Polygon, 4326) not null
);

INSERT INTO intergranular_lane (time, shape)
SELECT time, shape FROM og_intergranular_lane;