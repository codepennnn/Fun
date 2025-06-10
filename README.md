SELECT
  SUM(CASE 
        WHEN DATEDIFF(DAY, ISNULL(ResubmitOn, CreatedOn), GETDATE()) = 0 
             AND ApprvStatus = 'pending' 
       THEN 1 ELSE 0 
      END) AS [Pending application days count: 0],

  SUM(CASE 
        WHEN DATEDIFF(DAY, ISNULL(ResubmitOn, CreatedOn), GETDATE()) = 1 
             AND ApprvStatus = 'pending' 
       THEN 1 ELSE 0 
      END) AS [Pending application days count: 1],

  SUM(CASE 
        WHEN DATEDIFF(DAY, ISNULL(ResubmitOn, CreatedOn), GETDATE()) > 2 
             AND ApprvStatus = 'pending' 
       THEN 1 ELSE 0 
      END) AS [Pending application days count: more than 2]

FROM EmployeeMaster;
