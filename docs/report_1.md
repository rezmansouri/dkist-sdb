<h1>Report one</h1>

## 1. Spatial/Spatiotemporal Investigation Ideas
### 1.1. Spatiotemporal Clustering

- Cluster by Time Intervals: Perform spatial clustering for each type within specific time intervals. This can reveal how granules of the same type cluster or disperse in certain areas over time.

```
WITH time_intervals AS (
    SELECT DISTINCT date_trunc('minute', time) AS interval_start
    FROM granule_1
),
clustered_granules AS (
    SELECT 
        date_trunc('minute', g.time) AS interval_start,
        unnest(ST_ClusterWithin(g.shape, 100)) AS cluster_geom
    FROM granule_1 g
    JOIN time_intervals ti ON date_trunc('minute', g.time) = ti.interval_start
    GROUP BY interval_start
)
SELECT 
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
    SELECT
        date_trunc('minute', time) AS interval_start,
        COUNT(*) AS granule_count,
        ST_Area(ST_ConvexHull(ST_Collect(shape))) AS area_of_spread
    FROM granule_type
    GROUP BY interval_start
),
density_by_interval AS (
    SELECT
        interval_start,
        granule_count,
        area_of_spread,
        CASE 
            WHEN area_of_spread > 0 THEN granule_count / area_of_spread
            ELSE NULL 
        END AS density
    FROM minutely_counts
)
SELECT 
    interval_start,
    granule_count,
    area_of_spread,
    density
FROM density_by_interval
WHERE density IS NOT NULL
ORDER BY density DESC
LIMIT 10;
```

### 1.2. Transformation Events (Probabilistic)

- Transformation Probability: By analyzing granules present within similar regions across consecutive timestamps, estimate the probability of one type transforming into another over time. Though currently we can't track specific granules, spatial overlap or proximity could suggest transformation trends.

- Temporal Patterns in Type Changes: Track how the distribution of each type changes over time to infer if certain types appear/disappear or transform during particular time periods.

### 1.3.  Interaction Analysis

- Intersection Events: Count how often granules intersect or come within a set distance in each time interval. Although you can’t track specific granules, counting intersections can provide insights into how frequently types overlap in space.

- Nearest Neighbor Analysis: For each granule, determine the closest granule of another type within each time interval. This can reveal general proximity patterns among types, even if not individual movements.

## 2. Indexing investigation (not for Kevin)
- GiST (Generalized Search Tree): indexes break up data into "things to one side", "things which overlap", "things which are inside" and can be used on a wide range of data-types, including GIS data. PostGIS uses an R-Tree index implemented on top of GiST to index spatial data. GiST is the most commonly-used and versatile spatial index method, and offers very good query performance.

- BRIN (Block Range Index): indexes operate by summarizing the spatial extent of ranges of table records. Search is done via a scan of the ranges. BRIN is only appropriate for use for some kinds of data (spatially sorted, with infrequent or no update). But it provides much faster index create time, and much smaller index size.

- SP-GiST (Space-Partitioned Generalized Search Tree) is a generic index method that supports partitioned search trees such as quad-trees, k-d trees, and radix trees (tries).