CREATE TABLE granule_with_lane (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP not null,
  tracked_id int,
  shape GEOMETRY(Polygon, 4326) not null
);

INSERT INTO granule_with_lane (time, shape)
SELECT time, shape FROM og_granule_with_lane WHERE ST_Area(shape) > 10000;