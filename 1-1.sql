SELECT CASE pref_name
          WHEN '徳島' THEN '四国'
          WHEN '香川' THEN '四国'
          WHEN '愛媛' THEN '四国'
          WHEN '高知' THEN '四国'
          WHEN '福岡' THEN '九州'
          WHEN '佐賀' THEN '九州'
          WHEN '長崎' THEN '九州'
          ELSE 'その他' END AS district,
       SUM(population)
  FROM PopTbl
 GROUP BY district;


SELECT pref_name,
				 SUM( CASE WHEN sex = '1' THEN population ELSE 0 END) AS cnt_m,
				 SUM( CASE WHEN sex = '2' THEN population ELSE 0 END) AS cnt_f
		 FROM PopTbl2
 GROUP BY pref_name;

SELECT CASE WHEN population < 100 THEN '01'
							WHEN population >= 100 AND population < 200 THEN '02'
							WHEN population >= 200 AND population < 300 THEN '03'
							WHEN population >= 300 THEN '04'
							ELSE NULL END AS pop_class,
				  COUNT(*) AS cnt
	  FROM PopTbl
  GROUP BY CASE WHEN population < 100 THEN '01'
							WHEN population >= 100 AND population < 200 THEN '02'
							WHEN population >= 200 AND population < 300 THEN '03'
							WHEN population >= 300 THEN '04'
							ELSE NULL END;


UPDATE SomeTable
		SET p_key = CASE WHEN p_key = 'a'
						THEN 'd'
						WHEN p_key = 'b'
						THEN 'a'
					ELSE p_key END
	  WHERE p_key IN ('a', 'b');


SELECT course_name,
			CASE WHEN course_id IN
						(SELECT course_id FROM OpenCourses WHERE month = '201806' )
						THEN '◯' ELSE '✗' END AS '6月',
			CASE WHEN course_id IN
						(SELECT course_id FROM OpenCourses WHERE month = '201807' )
						THEN '◯' ELSE '✗' END AS '7月',
			CASE WHEN course_id IN
						(SELECT course_id FROM OpenCourses WHERE month = '201808' )
						THEN '◯' ELSE '✗' END AS '8月'

	FROM CourseMaster;

SELECT course_name,
			CASE WHEN EXISTS
						(SELECT course_id FROM OpenCourses OS WHERE month = '201806' AND OS.course_id = CM.course_id)
						THEN '◯' ELSE '✗' END AS '6月',
			CASE WHEN EXISTS
						(SELECT course_id FROM OpenCourses OS WHERE month = '201807' AND OS.course_id = CM.course_id)
						THEN '◯' ELSE '✗' END AS '7月',
			CASE WHEN EXISTS
						(SELECT course_id FROM OpenCourses OS WHERE month = '201808' AND OS.course_id = CM.course_id)
						THEN '◯' ELSE '✗' END AS '8月'

	FROM CourseMaster CM;


SELECT std_id,
				 CASE WHEN COUNT(*) = 1 THEN MAX(club_id )
				 ELSE MAX(CASE WHEN main_club_flg = 'Y'
													  THEN club_id
										  ELSE NULL END) END AS main_club
		FROM StudentClub
GROUP BY std_id;


SELECT key,
    CASE WHEN
        CASE WHEN x < y THEN y  ELSE x END  < z
            THEN z
            ELSE CASE WHEN x < y THEN y ELSE x END
    END AS greatest

FROM Greatests;


SELECT sex,
	SUM(population) AS total,
	SUM(CASE WHEN pref_name = '徳島'
							 THEN population ELSE 0 END) AS tokushima,
	SUM(CASE WHEN pref_name = '香川'
							 THEN population ELSE 0 END) AS kagawa,
	SUM(CASE WHEN pref_name = '愛媛'
							THEN population ELSE 0 END) AS ehime,
	SUM(CASE WHEN pref_name = '高知'
							THEN population ELSE 0 END) AS kouchi,
	SUM(CASE WHEN pref_name IN ('徳島', '香川', '愛媛', '高知')
							THEN population ELSE 0 END) AS saikei
FROM PopTbl2
GROUP BY sex;


SELECT key
FROM Greatests
ORDER BY CASE  key WHEN  'A' THEN 2
	WHEN 'B' THEN 1
	WHEN 'C' THEN 3
	WHEN 'D' THEN 4
	ELSE NULL END ASC;
