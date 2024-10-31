CREATE TABLE granule_with_dot_gist AS TABLE granule_with_dot;
CREATE TABLE granule_with_lane_gist AS TABLE granule_with_lane;
CREATE TABLE complex_granule_gist AS TABLE complex_granule;
CREATE TABLE uniform_granule_gist AS TABLE uniform_granule;
CREATE TABLE intergranular_lane_gist AS TABLE intergranular_lane;

CREATE TABLE granule_with_dot_brin AS SELECT * FROM granule_with_dot ORDER BY shape;
CREATE TABLE granule_with_lane_brin AS SELECT * FROM granule_with_lane ORDER BY shape;
CREATE TABLE complex_granule_brin AS SELECT * FROM complex_granule ORDER BY shape;
CREATE TABLE uniform_granule_brin AS SELECT * FROM uniform_granule ORDER BY shape;
CREATE TABLE intergranular_lane_brin AS SELECT * FROM intergranular_lane ORDER BY shape;

CREATE TABLE granule_with_dot_sp_gist AS TABLE granule_with_dot;
CREATE TABLE granule_with_lane_sp_gist AS TABLE granule_with_lane;
CREATE TABLE complex_granule_sp_gist AS TABLE complex_granule;
CREATE TABLE uniform_granule_sp_gist AS TABLE uniform_granule;
CREATE TABLE intergranular_lane_sp_gist AS TABLE intergranular_lane;
