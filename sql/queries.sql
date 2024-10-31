-- no index
EXPLAIN ANALYZE
SELECT
    *
FROM
    uniform_granule
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_dot
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_lane
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    complex_granule
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    intergranular_lane
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';

-- gist index
EXPLAIN ANALYZE
SELECT
    *
FROM
    uniform_granule_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_dot_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_lane_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    complex_granule_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    intergranular_lane_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';

-- brin index
EXPLAIN ANALYZE
SELECT
    *
FROM
    uniform_granule_brin
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_dot_brin
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_lane_brin
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    complex_granule_brin
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    intergranular_lane_brin
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';

-- sp_gist index
EXPLAIN ANALYZE
SELECT
    *
FROM
    uniform_granule_sp_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_dot_sp_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    granule_with_lane_sp_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    complex_granule_sp_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';
EXPLAIN ANALYZE
SELECT
    *
FROM
    intergranular_lane_sp_gist
WHERE
    ST_DWithin(
        shape,
        ST_SetSRID(ST_MakePoint(1727, 1727), 4326),
        1000
    )
    AND date_trunc('second', time) = '2022-05-26 18:03:45';