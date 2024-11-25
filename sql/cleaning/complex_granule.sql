CREATE TABLE complex_granule (
  id SERIAL PRIMARY KEY,
  time TIMESTAMP not null,
  tracked_id int,
  shape GEOMETRY(Polygon, 4326) not null
);

INSERT INTO complex_granule (time, shape)
SELECT time, shape FROM og_complex_granule WHERE ST_Area(shape) > 2500;