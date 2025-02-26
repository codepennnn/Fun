 select  distinct top 1 NEWID() as ID,'2024' AS Period, case when ISNUMERIC(l1.NOOF_WORKERS)=1 and  
 ((CONVERT(float, (l1.NOOF_WORKERS))) >= 0 and SUBSTRING(l1.proc_month, 1, 4) = '2024') then convert(int,l1.NOOF_WORKERS) else null end as Number_Employe_Engage,
 case when  ISNUMERIC(l1.NOOF_WORKERS)=1 and ((CONVERT(float, (l1.NOOF_WORKERS))) >= 0 and SUBSTRING(l1.proc_month, 1, 4) = '2024') then convert(int,l1.NOOF_WORKERS)
 else null end as Eligible_Bonus, case when ISNUMERIC(l1.W_BANK)=1 and ISNUMERIC(l1.W_CASH)=1 and ISNUMERIC(l1.W_CHEQUE)=1 and 
 ((CONVERT(float, (l1.W_BANK))) + (CONVERT(float, (l1.W_CASH))) + (CONVERT(float, (l1.W_CHEQUE))) >= 0 and SUBSTRING(l1.proc_month, 1, 4) = '2024')
 then convert(decimal(18,2),W_BANK)+convert(decimal(18, 2), W_CASH) + convert(decimal(18, 2), W_CHEQUE) else null end as Bonus_Amnt_Payable, case when 
 ISNUMERIC(l1.W_BANK)=1 and ISNUMERIC(l1.W_CASH)=1 and ISNUMERIC(l1.W_CHEQUE)=1 and
 ((CONVERT(float, (l1.W_BANK))) + (CONVERT(float, (l1.W_CASH))) + (CONVERT(float, (l1.W_CHEQUE))) >= 0 and SUBSTRING(l1.proc_month, 1, 4) = '2024')
 then convert(decimal(18,2),W_BANK)+convert(decimal(18, 2), W_CASH) + convert(decimal(18, 2), W_CHEQUE) else null end as Bonus_Amnt_Paid, 
 case when((CONVERT(float, ('0'))) >= 0 and SUBSTRING(l1.proc_month, 1, 4) = '2024')
 then convert(decimal(18,2),'0') else null end as Unpaid_Amnt from JCMS_C_ENTRY_DETAILS l1
 where RIGHT(l1.V_CODE, 5) = '14494' and l1.WO_NO = '2500011929' and l1.c_no = 8
