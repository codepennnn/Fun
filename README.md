 DECLARE @DynamicColumns NVARCHAR(MAX); DECLARE @SQLQuery NVARCHAR(MAX);

 SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',') FROM
 ( SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth FROM dbo.ListOfDaysByEngagementType('10', '2024') AS ML
 LEFT JOIN App_AttendanceDetails AS ad ON ML.Dates = AD.Dates WHERE AD.VendorCode = '17201' AND DATEPART(MONTH, AD.Dates) = '10'
 AND DATEPART(YEAR, AD.Dates) = '2024' AND AD.AadharNo = '699430160267' ) AS Days;

 SET @SQLQuery = ' WITH AttendanceData AS ( SELECT DATEPART(DAY, ML.Dates) AS DayOfMonth, ad.WorkManSl AS WorkManSLNo, ad.WorkManName AS WorkManName,


   case when( ML.EngagementType = AD.EngagementType and Present = ''True'')
   then Convert(varchar,1) else Convert(varchar,0) end as Present ,
   ad.EngagementType as Eng_Type from dbo.ListOfDaysByEngagementType(''10'',''2024'')
   as ML

 LEFT JOIN App_AttendanceDetails AS ad ON ML.Dates = AD.Dates WHERE AD.VendorCode = ''17201'' AND DATEPART(MONTH, AD.Dates) = ''10'' AND DATEPART(YEAR, AD.Dates) = ''2024'' 
 AND AD.AadharNo = ''699430160267'' ) 
 
 
 SELECT WorkManSLNo, WorkManName, ' + @DynamicColumns + ' FROM AttendanceData PIVOT ( MAX(Present) FOR DayOfMonth IN (' + @DynamicColumns + ') )
 AS PivotTable ORDER BY WorkManSLNo; ';

 EXEC sp_executesql @SQLQuery;
