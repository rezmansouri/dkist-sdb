CREATE INDEX ON complex_granule_gist USING GIST(shape);
CREATE INDEX ON uniform_granule_gist USING GIST(shape);
CREATE INDEX ON granule_with_dot_gist USING GIST(shape);
CREATE INDEX ON granule_with_lane_gist USING GIST(shape);
CREATE INDEX ON intergranular_lane_gist USING GIST(shape);

CREATE INDEX ON complex_granule_gist (time);
CREATE INDEX ON uniform_granule_gist (time);
CREATE INDEX ON granule_with_dot_gist (time);
CREATE INDEX ON granule_with_lane_gist (time);
CREATE INDEX ON intergranular_lane_gist (time);

CREATE INDEX ON complex_granule_brin USING BRIN(shape);
CREATE INDEX ON uniform_granule_brin USING BRIN(shape);
CREATE INDEX ON granule_with_dot_brin USING BRIN(shape);
CREATE INDEX ON granule_with_lane_brin USING BRIN(shape);
CREATE INDEX ON intergranular_lane_brin USING BRIN(shape);

CREATE INDEX ON complex_granule_brin (time);
CREATE INDEX ON uniform_granule_brin (time);
CREATE INDEX ON granule_with_dot_brin (time);
CREATE INDEX ON granule_with_lane_brin (time);
CREATE INDEX ON intergranular_lane_brin (time);

CREATE INDEX ON complex_granule_sp_gist USING SPGIST(shape);
CREATE INDEX ON uniform_granule_sp_gist USING SPGIST(shape);
CREATE INDEX ON granule_with_dot_sp_gist USING SPGIST(shape);
CREATE INDEX ON granule_with_lane_sp_gist USING SPGIST(shape);
CREATE INDEX ON intergranular_lane_sp_gist USING SPGIST(shape);

CREATE INDEX ON complex_granule_sp_gist (time);
CREATE INDEX ON uniform_granule_sp_gist (time);
CREATE INDEX ON granule_with_dot_sp_gist (time);
CREATE INDEX ON granule_with_lane_sp_gist (time);
CREATE INDEX ON intergranular_lane_sp_gist (time);