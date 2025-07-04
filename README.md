INSERT INTO App_UserFormPermission (UserID, FormId, AllowRead, AllowWrite, AllowDelete, AllowAll, AllowModify, DownTime)
SELECT u.UserID, 'B7EAEBB7-B705-4542-A644-09BEB0BA0379', 1, 1, 0, 0, 1, 0
FROM userlogindb.dbo.aspnet_Membership u
