<h1>Report one</h1>

## 1. Spatial/Spatiotemporal Investigation Ideas
### 1.1. Spatiotemporal Clustering

- Cluster by Time Intervals: Perform spatial clustering for each type within specific time intervals. This can reveal how granules of the same type cluster or disperse in certain areas over time.

- Temporal Hotspots: Identify periods when a certain type is most densely present, giving insights into the timing of high-density occurrences.

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