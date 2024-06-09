SELECT num AS prime
		FROM Numbers Dividend
	WHERE num > 1
		AND NOT EXISTS
						(SELECT *
								FROM Numbers Divisor
							WHERE Divisor.num <= Dividend.num / 2
							 AND Divisor.num <> 1
							 AND Dividend.num % Divisor.num = 0)
	 GROUP BY prime;
