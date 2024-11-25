WITH granules as (
select * from complex_granule WHERE date_trunc('second', time) = '2022-05-26 17:46:29'
) DELETE from complex_granule WHERE id in (select a.id FROM granules AS a join granules AS b on a.shape = b.shape WHERE a.id > b.id order by a.id);