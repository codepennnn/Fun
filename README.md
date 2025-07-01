SELECT 
    Remarks,
    SUBSTRING(
        Remarks,
        LEN(Remarks) - CHARINDEX(',', REVERSE(Remarks)) + 2,
        LEN(Remarks)
    ) AS LastRemark
FROM YourTable;
