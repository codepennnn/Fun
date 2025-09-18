SELECT *
FROM App_vendorwodetails
WHERE UPDATEDAT >= CAST(GETDATE() AS date) - 7;
