SELECT *
FROM (
       SELECT  *,
               DATEDIFF(day, CreatedOn, GETDATE()) AS dayscountCreatedOn,
               DATEDIFF(day, ResubmitedOn, GETDATE()) AS dayscountResub,
               ROW_NUMBER() OVER (PARTITION BY RefNo ORDER BY CreatedOn DESC) AS rn
       FROM App_Half_Yearly_Details
     ) A
WHERE A.rn = 1;
