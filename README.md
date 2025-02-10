SELECT * 
FROM App_Online_Wages 
WHERE CreatedOn >= '2024-01-01 00:00:00.00' 
AND CreatedOn < '2025-01-01 00:00:00.00' 
AND ID NOT IN (SELECT ID FROM App_Online_Wages_Details)
ORDER BY CreatedOn DESC;
