SELECT 
    Remarks,
    LTRIM(RTRIM(
        CASE 
            WHEN CHARINDEX(',', Remarks) = 0 THEN Remarks -- only one remark
            ELSE SUBSTRING(
                Remarks,
                LEN(Remarks) - CHARINDEX(',', REVERSE(Remarks)) + 2,
                LEN(Remarks)
            )
        END
    )) AS LastRemark
FROM YourTable;
