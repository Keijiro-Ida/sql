SELECT shohin_id, shohin_mei, hanbai_tanka,
		AVG(hanbai_tanka) OVER (ORDER BY shohin_id
            ROWS BETWEEN 2 PRECEDING
                    AND CURRENT ROW)
        AS moving_avg
FROM Shohin;

SELECT shohin_id, shohin_mei, hanbai_tanka,
		AVG(hanbai_tanka) OVER W AS moving_avg
    FROM Shohin
WINDOW W AS (ORDER BY shohin_id
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);

SELECT shohin_id,
		AVG(hanbai_tanka) OVER W AS moving_avg,
		SUM(hanbai_tanka) OVER W AS moving_sum,
		COUNT(hanbai_tanka) OVER W AS moving_count,
		MAX(hanbai_tanka) OVER W AS moving_max
FROM Shohin
WINDOW W AS (ORDER BY shohin_id
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);


SELECT sample_date AS cur_date,
		MIN(sample_date)
				OVER (ORDER BY sample_date ASC
						ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS latest_date
	FROM LoadSample

SELECT sample_date AS cur_date,
		MIN(sample_date)
				OVER (ORDER BY sample_date ASC
						ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS latest_date,

		MIN(load_val)
				OVER (ORDER BY sample_date ASC
						ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS latest_load
	FROM LoadSample

SELECT sample_date AS cur_date,
		MIN(sample_date)
				OVER W AS latest_date,

		MIN(load_val)
				OVER W AS latest_load
	FROM LoadSample
	WINDOW W AS (ORDER BY sample_date ASC
						ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)

SELECT sample_date AS cur_date,
       MIN(sample_date)
			OVER (ORDER BY sample_date ASC
					ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS latest_1,
		MIN(sample_date)
			OVER (ORDER BY sample_date ASC
					ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING) AS latest_2,
		MIN(sample_date)
			OVER (ORDER BY sample_date ASC
					ROWS BETWEEN 3 PRECEDING AND 3 PRECEDING) AS latest_3
  FROM LoadSample;

SELECT server, sample_date,
		SUM(load_val) OVER (PARTITION BY server) AS sum_load
	FROM ServerLoadSample;
