
 select sum(Max_Wage_Rate) as total_gross_wage,
 sum(Net_Bonus_Payable) as TotalBonusPayableAmount 
 ,
 
 (select sum(Max_Wage_Rate) from App_Bonus_Generation_Details where Vcode='17476' and Year='2024-2025' and cast(Total_No_of_days_worked as int)>=30  ) as total_Earned,

 ( select count( distinct AdharNo ) from App_Bonus_Generation_Details where Total_No_of_days_worked >=30 
 and Vcode='17476' and Year='2024-2025' )  as eg_headcount,( select count( distinct AdharNo )
 from App_Bonus_Generation_Details where Total_No_of_days_worked <30 and Vcode='17476' and Year='2024-2025' )  as not_eg_headcount    from App_Bonus_Generation_Details where Vcode='17476' and Year='2024-2025'  

