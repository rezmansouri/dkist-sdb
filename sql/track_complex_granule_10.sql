UPDATE complex_granule SET tracked_id = CASE
	WHEN id=89 THEN 7531
	WHEN id=90 THEN 7532
	WHEN id=91 THEN 7533
	WHEN id=105 THEN 7534
	WHEN id=106 THEN 7535
	WHEN id=115 THEN 7536
	WHEN id=116 THEN 7537
	WHEN id=117 THEN 7538
	WHEN id=121 THEN 7539 END WHERE id IN (89, 90, 91, 105, 106, 115, 116, 117, 121);