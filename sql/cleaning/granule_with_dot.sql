CREATE TABLE granule_with_dot (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP not null,
  tracked_id int,
  shape GEOMETRY(Polygon, 4326) not null
);

INSERT INTO granule_with_dot (time, shape)
SELECT time, shape FROM og_granule_with_dot WHERE ST_Area(shape) > 12000;