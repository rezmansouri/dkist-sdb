CREATE TABLE uniform_granule (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP not null,
  tracked_id int,
  shape GEOMETRY(Polygon, 4326) not null
);

INSERT INTO uniform_granule (time, shape)
SELECT time, shape FROM og_uniform_granule WHERE ST_Area(shape) > 7000;