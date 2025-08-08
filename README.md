i have two table both table have createdon i want to join it and


select * from App_Gov_Notice where ID='F5E1DDB3-43D3-4F07-918C-FFFF7255F937'
select * from App_Gov_Notice_Details where MASTER_ID='F5E1DDB3-43D3-4F07-918C-FFFF7255F937'







WITH PFESIProcessed AS (




      SELECT 
        *, 
        CREATEDON AS ApplicationDate
    FROM App_PF_ESI_Summary
    WHERE Details.CREATEDON IS NULL

    UNION ALL

    SELECT 
        *, 
        Details.CREATEDON AS ApplicationDate
    FROM App_PF_ESI_Summary
    WHERE Details.CREATEDON IS NOT NULL
),


PFESIFiltered AS (
   SELECT *
    FROM PFESIProcessed
    WHERE ApplicationDate >= '2025-04-01' AND ApplicationDate < '2026-04-01'
),


PFESIAggregated AS (
   SELECT
        FORMAT(ApplicationDate, 'yyyy-MM') AS MonthYear,
        DATENAME(MONTH, ApplicationDate) AS MonthName,
        LEFT(DATENAME(MONTH, ApplicationDate), 3) AS MonthShort,
        DATEPART(MONTH, ApplicationDate) AS MonthNum,
        SUM(CASE WHEN Status = 'CLOSE' THEN 1 ELSE 0 END) AS Approved,
        SUM(CASE 
            WHEN Status = 'CLOSE' 
              AND ClosedOn IS NOT NULL 
              AND DATEDIFF(DAY, ApplicationDate, ClosedOn) <= 3 
            THEN 1 ELSE 0 
        END) AS ApprovedUnderSLA
    FROM PFESIFiltered
    GROUP BY FORMAT(ApplicationDate, 'yyyy-MM'), DATEPART(MONTH, ApplicationDate), DATENAME(MONTH, ApplicationDate)
),


PFESIPivoted AS (
    SELECT
        'Govt Notice' AS Object,
        '1 days' AS SLG,
        '1 days' AS RevisedSLG,

     
        ISNULL( MAX(CASE WHEN MonthNum = 4 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS APR,
        ISNULL (MAX(CASE WHEN MonthNum = 4 THEN ApprovedUnderSLA ELSE NULL END),0) AS APR_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 5 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS MAY,
        ISNULL ( MAX(CASE WHEN MonthNum = 5 THEN ApprovedUnderSLA ELSE NULL END),0) AS MAY_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 6 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS JUN,
        ISNULL ( MAX(CASE WHEN MonthNum = 6 THEN ApprovedUnderSLA ELSE NULL END),0) AS JUN_Value,

        ISNULL ( MAX(CASE WHEN MonthNum = 7 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS JUL,
        ISNULL ( MAX(CASE WHEN MonthNum = 7 THEN ApprovedUnderSLA ELSE NULL END),0) AS JUL_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 8 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS AUG,
         ISNULL (MAX(CASE WHEN MonthNum = 8 THEN ApprovedUnderSLA ELSE NULL END),0) AS AUG_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 9 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS SEP,
         ISNULL (MAX(CASE WHEN MonthNum = 9 THEN ApprovedUnderSLA ELSE NULL END),0) AS SEP_Value,

        ISNULL ( MAX(CASE WHEN MonthNum = 10 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS OCT,
         ISNULL (MAX(CASE WHEN MonthNum = 10 THEN ApprovedUnderSLA ELSE NULL END),0) AS OCT_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 11 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS NOV,
         ISNULL (MAX(CASE WHEN MonthNum = 11 THEN ApprovedUnderSLA ELSE NULL END),0) AS NOV_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 12 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS DEC,
         ISNULL (MAX(CASE WHEN MonthNum = 12 THEN ApprovedUnderSLA ELSE NULL END),0) AS DEC_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 1 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS JAN,
         ISNULL (MAX(CASE WHEN MonthNum = 1 THEN ApprovedUnderSLA ELSE NULL END),0) AS JAN_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 2 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS FEB,
         ISNULL (MAX(CASE WHEN MonthNum = 2 THEN ApprovedUnderSLA ELSE NULL END),0) AS FEB_Value,

        ISNULL ( MAX(CASE WHEN MonthNum = 3 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS MAR,
         ISNULL (MAX(CASE WHEN MonthNum = 3 THEN ApprovedUnderSLA ELSE NULL END),0) AS MAR_Value

    FROM PFESIAggregated
)
select * from PFESIPivoted


