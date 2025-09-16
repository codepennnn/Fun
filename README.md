
Select SUBSTRING((select * from(select ',' + m.Email COLLATE database_default 'data()' from UserLoginDB.dbo.aspnet_Users as q,
UserLoginDB.dbo.aspnet_Membership m where q.UserName = '10511' and m.UserId = q.UserId union select ',' 
+ Email from App_Vendor_Representative   where CREATEDBY = '10511'   ) A FOR XML PATH('') ), 2 , 9999) As Email

 
