DAY(EOMONTH('"+month+ "/01/" + year + "')) - DATEDIFF(ww, CAST('20241001' AS datetime) - 1, '20241031') TotWorkingDays
explain this
