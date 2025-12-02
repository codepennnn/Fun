select * ,DATEDIFF(day, CreatedOn,getdate()) as dayscountCreatedOn,DATEDIFF(day, ResubmitedOn, getdate()) as dayscountResub from App_Half_Yearly_Details

i want only here distinct records appear of refno
