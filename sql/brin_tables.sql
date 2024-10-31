CREATE TABLE complex_granule_brin AS SELECT * FROM complex_granule_gist ORDER BY shape;
CREATE TABLE granule_with_dot_brin AS SELECT * FROM granule_with_dot_gist ORDER BY shape;
CREATE TABLE granule_with_lane_brin AS SELECT * FROM granule_with_lane_gist ORDER BY shape;
CREATE TABLE intergranular_lane_brin AS SELECT * FROM intergranular_lane_gist ORDER BY shape;
CREATE TABLE uniform_granule_brin AS SELECT * FROM uniform_granule_gist ORDER BY shape;