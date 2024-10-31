UPDATE complex_granule_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE uniform_granule_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE granule_with_dot_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE granule_with_lane_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE intergranular_lane_gist SET shape = ST_Simplify(shape, 0.1);

UPDATE complex_granule_sp_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE uniform_granule_sp_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE granule_with_dot_sp_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE granule_with_lane_sp_gist SET shape = ST_Simplify(shape, 0.1);
UPDATE intergranular_lane_sp_gist SET shape = ST_Simplify(shape, 0.1);

UPDATE complex_granule_brin SET shape = ST_Simplify(shape, 0.1);
UPDATE uniform_granule_brin SET shape = ST_Simplify(shape, 0.1);
UPDATE granule_with_dot_brin SET shape = ST_Simplify(shape, 0.1);
UPDATE granule_with_lane_brin SET shape = ST_Simplify(shape, 0.1);
UPDATE intergranular_lane_brin SET shape = ST_Simplify(shape, 0.1);
