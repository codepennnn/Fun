WITH AttendanceData AS (
    SELECT 
        DATEPART(DAY, ML.Dates) AS DayOfMonth,
        ad.WorkManSl AS WorkManSLNo,
        ad.WorkManName AS WorkManName,
        CASE 
            WHEN (ML.EngagementType = AD.EngagementType AND AD.Present = 'True') 
            THEN 1 
            ELSE 0 
        END AS Present
    FROM 
        dbo.ListOfDaysByEngagementType('10', '2024') AS ML
    LEFT JOIN 
        App_AttendanceDetails AS ad 
    ON 
        ML.Dates = AD.Dates
    WHERE 
        AD.VendorCode = '17201' 
        AND DATEPART(MONTH, AD.Dates) = '10' 
        AND DATEPART(YEAR, AD.Dates) = '2024' 
        AND AD.AadharNo = '275225445020'
)
SELECT 
    WorkManSLNo,
    WorkManName,
    -- Dynamically create columns for the days present in the data
    MAX(CASE WHEN DayOfMonth = 1 THEN Present ELSE 0 END) AS [Day 1],
    MAX(CASE WHEN DayOfMonth = 2 THEN Present ELSE 0 END) AS [Day 2],
    MAX(CASE WHEN DayOfMonth = 3 THEN Present ELSE 0 END) AS [Day 3],
    MAX(CASE WHEN DayOfMonth = 4 THEN Present ELSE 0 END) AS [Day 4],
    MAX(CASE WHEN DayOfMonth = 5 THEN Present ELSE 0 END) AS [Day 5],
    MAX(CASE WHEN DayOfMonth = 6 THEN Present ELSE 0 END) AS [Day 6],
    MAX(CASE WHEN DayOfMonth = 7 THEN Present ELSE 0 END) AS [Day 7],
    MAX(CASE WHEN DayOfMonth = 8 THEN Present ELSE 0 END) AS [Day 8],
    MAX(CASE WHEN DayOfMonth = 9 THEN Present ELSE 0 END) AS [Day 9],
    MAX(CASE WHEN DayOfMonth = 10 THEN Present ELSE 0 END) AS [Day 10],
    MAX(CASE WHEN DayOfMonth = 11 THEN Present ELSE 0 END) AS [Day 11],
    MAX(CASE WHEN DayOfMonth = 12 THEN Present ELSE 0 END) AS [Day 12],
    MAX(CASE WHEN DayOfMonth = 13 THEN Present ELSE 0 END) AS [Day 13],
    MAX(CASE WHEN DayOfMonth = 14 THEN Present ELSE 0 END) AS [Day 14],
    MAX(CASE WHEN DayOfMonth = 15 THEN Present ELSE 0 END) AS [Day 15],
    MAX(CASE WHEN DayOfMonth = 16 THEN Present ELSE 0 END) AS [Day 16],
    MAX(CASE WHEN DayOfMonth = 17 THEN Present ELSE 0 END) AS [Day 17],
    MAX(CASE WHEN DayOfMonth = 18 THEN Present ELSE 0 END) AS [Day 18],
    MAX(CASE WHEN DayOfMonth = 19 THEN Present ELSE 0 END) AS [Day 19],
    MAX(CASE WHEN DayOfMonth = 20 THEN Present ELSE 0 END) AS [Day 20],
    MAX(CASE WHEN DayOfMonth = 21 THEN Present ELSE 0 END) AS [Day 21],
    MAX(CASE WHEN DayOfMonth = 22 THEN Present ELSE 0 END) AS [Day 22],
    MAX(CASE WHEN DayOfMonth = 23 THEN Present ELSE 0 END) AS [Day 23],
    MAX(CASE WHEN DayOfMonth = 24 THEN Present ELSE 0 END) AS [Day 24],
    MAX(CASE WHEN DayOfMonth = 25 THEN Present ELSE 0 END) AS [Day 25],
    MAX(CASE WHEN DayOfMonth = 26 THEN Present ELSE 0 END) AS [Day 26],
    MAX(CASE WHEN DayOfMonth = 27 THEN Present ELSE 0 END) AS [Day 27],
    MAX(CASE WHEN DayOfMonth = 28 THEN Present ELSE 0 END) AS [Day 28],
    MAX(CASE WHEN DayOfMonth = 29 THEN Present ELSE 0 END) AS [Day 29],
    MAX(CASE WHEN DayOfMonth = 30 THEN Present ELSE 0 END) AS [Day 30],
    MAX(CASE WHEN DayOfMonth = 31 THEN Present ELSE 0 END) AS [Day 31]
FROM 
    AttendanceData
GROUP BY 
    WorkManSLNo,
    WorkManName
ORDER BY 
    WorkManSLNo;
