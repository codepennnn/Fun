lINSERT INTO App_UserFormPermission (FormId, AllowRead, AllowWrite, AllowDelete, AllowAll, AllowModify, DownTime, UserID)
SELECT 
    FormId, 
    1 AS AllowRead,    -- Set AllowRead to 1
    0 AS AllowWrite,   -- Set AllowWrite to 0
    0 AS AllowDelete,  -- Set AllowDelete to 0
    0 AS AllowAll,     -- Set AllowAll to 0
    0 AS AllowModify,  -- Set AllowModify to 0
    0 AS DownTime,     -- Set DownTime to 0
    '155048' AS UserID -- Set the new UserID
FROM 
    ONLINE_USERPERMISSION 
WHERE 
    UserID = '159631'; -- Filter for the existing UserID
