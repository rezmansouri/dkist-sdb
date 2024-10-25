<h1>Report one</h1>

## 1. Spatial/Spatiotemporal Investigation Ideas
### 1.1. Spatiotemporal Clustering

- Cluster by Time Intervals: Perform spatial clustering for each type within specific time intervals. This can reveal how granules of the same type cluster or disperse in certain areas over time.

```
WITH time_intervals AS (
    -- Define minutely intervals
    SELECT DISTINCT date_trunc('minute', time) AS interval_start
    FROM granule_1
),
clustered_granules AS (
    -- Cluster bubbles within each minutely interval by type
    SELECT 
        date_trunc('minute', g.time) AS interval_start,
        unnest(ST_ClusterWithin(g.shape, 100)) AS cluster_geom
    FROM granule_1 g
    JOIN time_intervals ti ON date_trunc('minute', g.time) = ti.interval_start
    GROUP BY interval_start
)
SELECT
-- Select and visualize each cluster's bounding box or other summary stats
    interval_start,
    type,
    cluster_geom, 
    ST_Centroid(cluster_geom) AS cluster_center,
    ST_Area(cluster_geom) AS cluster_area
FROM clustered_granules;

```

- Temporal Hotspots: Identify periods when a certain type is most densely present, giving insights into the timing of high-density occurrences.

```
WITH minutely_counts AS (
    -- Aggregate granules by minute, counting them and calculating their spread area
    SELECT
        date_trunc('minute', time) AS interval_start,
        COUNT(*) AS granule_count,
        ST_Area(ST_ConvexHull(ST_Collect(shape))) AS area_of_spread
    FROM granule_type_1  -- Replace with the actual granule type table name
    GROUP BY interval_start
),
density_by_interval AS (
    -- Calculate density as count per unit area
    SELECT
        interval_start,
        granule_count,
        area_of_spread,
        CASE 
            WHEN area_of_spread > 0 THEN granule_count::float / area_of_spread
            ELSE NULL 
        END AS density
    FROM minutely_counts
)
-- Select intervals with the highest density
SELECT 
    interval_start,
    granule_count,
    area_of_spread,
    density
FROM density_by_interval
WHERE density IS NOT NULL
ORDER BY density DESC
LIMIT 10;  -- Adjust limit based on how many high-density periods you want to examine
```

### 1.2. Transformation Events (Probabilistic)

- Transformation Probability: By analyzing granules present within similar regions across consecutive timestamps, estimate the probability of one type transforming into another over time. Though currently we can't track specific granules, spatial overlap or proximity could suggest transformation trends.

```
WITH current_interval AS (
    -- Select granules from granule_type_1 for each minute
    SELECT 
        date_trunc('minute', time) AS interval_start,
        id AS granule_id,
        shape
    FROM granule_type_1
),
next_interval AS (
    -- Select granules from granule_type_2 for each minute, shifted by one minute
    SELECT 
        date_trunc('minute', time) - interval '1 minute' AS interval_start,
        id AS granule_id,
        shape
    FROM granule_type_2
),
possible_transformations AS (
    -- Identify granules in granule_type_1 that are spatially close to granule_type_2 granules in the next minute
    SELECT 
        ci.interval_start,
        COUNT(DISTINCT ci.granule_id) AS granules_in_type_1,
        COUNT(DISTINCT ni.granule_id) AS matching_granules_in_type_2,
        COUNT(DISTINCT ci.granule_id) FILTER (WHERE ST_DWithin(ci.shape, ni.shape, 100)) AS close_granules_in_type_2
    FROM current_interval ci
    LEFT JOIN next_interval ni 
    ON ci.interval_start = ni.interval_start
    WHERE ST_DWithin(ci.shape, ni.shape, 100)  -- Only include close granules in each type
    GROUP BY ci.interval_start
)
-- Calculate the transformation probability as the proportion of close matches
SELECT 
    interval_start,
    granules_in_type_1,
    matching_granules_in_type_2,
    close_granules_in_type_2,
    CASE 
        WHEN granules_in_type_1 > 0 THEN close_gran
```
- Temporal Patterns in Type Changes: Track how the distribution of each type changes over time to infer if certain types appear/disappear or transform during particular time periods.
```
WITH type_counts AS (
    -- Aggregate counts of granules for each type by minute
    SELECT
        date_trunc('minute', time) AS interval_start,
        'granule_type_1' AS granule_type,
        COUNT(*) AS granule_count
    FROM granule_type_1  -- Replace with the actual table name for the first granule type
    GROUP BY interval_start

    UNION ALL

    SELECT
        date_trunc('minute', time) AS interval_start,
        'granule_type_2' AS granule_type,
        COUNT(*) AS granule_count
    FROM granule_type_2  -- Replace with the actual table name for the second granule type
    GROUP BY interval_start
)
-- Select the counts for each type, allowing visualization of temporal patterns
SELECT 
    interval_start,
    granule_type,
    granule_count
FROM type_counts
ORDER BY interval_start, granule_type;
```

### 1.3.  Interaction Analysis

- Intersection Events: Count how often granules intersect or come within a set distance in each time interval. Although you can’t track specific granules, counting intersections can provide insights into how frequently types overlap in space.
```
WITH granule_intersections AS (
    -- Select granules from both types and their intersection counts within each minute
    SELECT 
        date_trunc('minute', g1.time) AS interval_start,
        COUNT(*) AS intersection_count
    FROM granule_type_1 g1
    JOIN granule_type_2 g2 
    ON ST_Intersects(g1.shape, g2.shape)  -- Check for intersections
    GROUP BY interval_start

    UNION ALL

    SELECT 
        date_trunc('minute', g1.time) AS interval_start,
        COUNT(*) AS intersection_count
    FROM granule_type_1 g1
    JOIN granule_type_1 g2 
    ON g1.id != g2.id AND ST_Intersects(g1.shape, g2.shape)  -- Intersecting the same type
    GROUP BY interval_start

    UNION ALL

    SELECT 
        date_trunc('minute', g2.time) AS interval_start,
        COUNT(*) AS intersection_count
    FROM granule_type_2 g1
    JOIN granule_type_2 g2 
    ON g1.id != g2.id AND ST_Intersects(g1.shape, g2.shape)  -- Intersecting the same type
    GROUP BY interval_start
)
-- Final selection to get intersection counts for each type
SELECT 
    interval_start,
    SUM(intersection_count) AS total_intersections
FROM granule_intersections
GROUP BY interval_start
ORDER BY interval_start;
```

- Nearest Neighbor Analysis: For each granule, determine the closest granule of another type within each time interval. This can reveal general proximity patterns among types, even if not individual movements.
```
WITH nearest_neighbors AS (
    -- Find the nearest granule of granule_type_2 for each granule of granule_type_1 within each time interval
    SELECT 
        date_trunc('minute', g1.time) AS interval_start,
        g1.id AS granule_id,
        g2.id AS nearest_granule_id,
        ST_Distance(g1.shape, g2.shape) AS distance
    FROM granule_type_1 g1
    JOIN granule_type_2 g2 
    ON date_trunc('minute', g1.time) = date_trunc('minute', g2.time)  -- Ensure they are in the same minute
    ORDER BY interval_start, g1.id, distance
),
ranked_neighbors AS (
    -- Rank the nearest neighbors for each granule of granule_type_1
    SELECT 
        interval_start,
        granule_id,
        nearest_granule_id,
        distance,
        ROW_NUMBER() OVER (PARTITION BY interval_start, granule_id ORDER BY distance) AS rn
    FROM nearest_neighbors
)
-- Select only the closest neighbor for each granule
SELECT 
    interval_start,
    granule_id,
    nearest_granule_id,
    distance
FROM ranked_neighbors
WHERE rn = 1  -- Get only the closest neighbor
ORDER BY interval_start, granule_id;
```

## 2. Indexing investigation (not for Kevin)
- GiST (Generalized Search Tree): indexes break up data into "things to one side", "things which overlap", "things which are inside" and can be used on a wide range of data-types, including GIS data. PostGIS uses an R-Tree index implemented on top of GiST to index spatial data. GiST is the most commonly-used and versatile spatial index method, and offers very good query performance.

- BRIN (Block Range Index): indexes operate by summarizing the spatial extent of ranges of table records. Search is done via a scan of the ranges. BRIN is only appropriate for use for some kinds of data (spatially sorted, with infrequent or no update). But it provides much faster index create time, and much smaller index size.

- SP-GiST (Space-Partitioned Generalized Search Tree) is a generic index method that supports partitioned search trees such as quad-trees, k-d trees, and radix trees (tries).