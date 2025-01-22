INSERT INTO App_UserFormPermission (FormId, AllowRead, AllowWrite,AllowDelete, AllowAll, AllowModify,DownTime, UserID)
SELECT FormId, AllowRead, AllowWrite,AllowDelete, AllowAll, AllowModify,DownTime, '155048'    --enter here 
FROM ONLINE_USERPERMISSION
WHERE userid = '159631';
