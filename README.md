
 select * from App_Leave_Comp_Summary where FORMAT((CreatedOn),'MM')='05' and FORMAT((CreatedOn),'yyyy')='2025' and ReSubmiteddate is null and Status='Request Closed' and DATEDIFF(day,CreatedOn,CC_CreatedOn_L2)<=5
 union all
select * from App_Leave_Comp_Summary where FORMAT((ReSubmiteddate),'MM')='05' and FORMAT((ReSubmiteddate),'yyyy')='2025' and Status='Request Closed' and DATEDIFF(day,ReSubmiteddate,CC_CreatedOn_L2)<=5

