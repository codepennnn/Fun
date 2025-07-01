SELECT 
    Remarks,
    LTRIM(RTRIM(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            Remarks, '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' ')
    )) AS CleanRemarks
FROM YourTable;
