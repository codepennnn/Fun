 (select(Count(ah.Hdate)) from App_HolidayMaster ah where DATEPART(month, ah.Hdate) = '2' and Location = LM.Location 
 and DATEPART(year, ah.Hdate) = '2025') as TotHoliDays,  DAY(EOMONTH('01/2/2025')) - DATEDIFF(ww, CAST('20241001' AS datetime) - 1, '20241031') TotWorkingDays, 
