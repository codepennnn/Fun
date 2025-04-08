DAY(EOMONTH('"+month+ "/01/" + year + "')) - DATEDIFF(ww, CAST('20241001' AS datetime) - 1, '20241031') TotWorkingDays
explain this


_----
DAY(EOMONTH('03/01/2025')) - DATEDIFF(ww, CAST('20250301' AS datetime) - 1, '20250331') - 
CASE WHEN DATENAME(weekday, '2025-03-31') = 'Sunday' THEN 1 ELSE 0 END
