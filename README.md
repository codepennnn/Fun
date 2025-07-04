INSERT INTO App_UserFormPermission (UserID, FormId, AllowRead, AllowWrite, AllowDelete, AllowAll, AllowModify, DownTime)
SELECT u.UserID, 'Model_Form_ID', 1, 1, 0, 0, 1, 0
FROM Users u
JOIN Vendors v ON u.UserID = v.UserID;
