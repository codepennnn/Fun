SELECT  newid() as ID,l.LicNo as LabourLicNo,
l.FromDate,l.ToDate,
convert(varchar(10),DATEDIFF(DAY, convert(datetime,FromDate,103),convert(datetime,ToDate,103))) AS Duration_Of_Contract,
 (select concat (V_NAME,', ',ADDRESS) from App_Vendor_Reg R where R.V_CODE=Vcode) as Name_Address_Of_Contractor
 ,c3.wo_no,

 (select count( distinct  w.AadharNo)
   from App_Wagesdetailsjharkhand w 
   inner join App_EmployeeMaster Em on em.AadharCard=w.AadharNo and em.Sex='M'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' ) sex_M,

   (select count( distinct  w.AadharNo)
   from App_Wagesdetailsjharkhand w 
   inner join App_EmployeeMaster Em on em.AadharCard=w.AadharNo and em.Sex='F'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' ) sex_F,


        
(select 
    SUM(tab.TotalMandays) AS TotalMandays_Male
from (

select  distinct  w.AadharNo,   SUM(w.TotPaymentDays) AS TotalMandays
   from app_wagesdetailsjharkhand w 
   inner join app_employeemaster em on em.aadharcard=w.aadharno and em.sex='M'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' group by AadharNo

  ) tab) TotalMandays_Male,


 ( select 
    SUM(tab.TotalMandays) AS TotalMandays_Male
from (

select  distinct  w.AadharNo,   SUM(w.TotPaymentDays) AS TotalMandays
   from app_wagesdetailsjharkhand w 
   inner join app_employeemaster em on em.aadharcard=w.aadharno and em.sex='F'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' group by AadharNo

  ) tab)TotalMandays_Female,





  (select 
  ISNULL(SUM(tab.Male_Deduction), 0) AS Male_Deduction
from (

select  distinct  w.AadharNo,   SUM(isnull(w.PFAmt,0) + (isnull(w.ESIAmt,0))) AS Male_Deduction
   from app_wagesdetailsjharkhand w 
   inner join app_employeemaster em on em.aadharcard=w.aadharno and em.sex='M'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' group by AadharNo

  ) tab) Male_Deduction,




  (select 
  ISNULL(SUM(tab.Female_Deduction), 0) AS Female_Deduction
from (

select  distinct  w.AadharNo,   SUM(isnull(w.PFAmt,0) +  isnull(w.ESIAmt,0)) AS Female_Deduction
   from app_wagesdetailsjharkhand w 
   inner join app_employeemaster em on em.aadharcard=w.aadharno and em.sex='F'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' group by AadharNo

  ) tab)Female_Deduction,




    (select 
  ISNULL(SUM(tab.Male_Gross), 0) AS Male_Gross
from (

select  distinct  w.AadharNo,   SUM((isnull(w.TotalWages,0))) AS Male_Gross
   from app_wagesdetailsjharkhand w 
   inner join app_employeemaster em on em.aadharcard=w.aadharno and em.sex='M'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' group by AadharNo

  ) tab) Male_Gross,




  (select 
  ISNULL(SUM(tab.Female_Gross), 0) AS Female_Gross
from (

select  distinct  w.AadharNo,  SUM((isnull(w.TotalWages,0)))  AS Female_Gross
   from app_wagesdetailsjharkhand w 
   inner join app_employeemaster em on em.aadharcard=w.aadharno and em.sex='F'
   where w.workorderno=c3.wo_no and w.vendorcode='17201' and w.monthwage in ('1','2','3','4','5','6')
  and w.yearwage='2025' group by AadharNo

  ) tab)Female_Gross








 FROM App_LabourLicenseSubmission l
 left join App_vendor_form_c3_dtl c3
 on c3.ll_no=l.licno 
 WHERE 
 c3.status='Approved'and
 FromDate < '2025-06-30 00:00:00.000' 
 AND ToDate >= '2025-01-01 00:00:00.000' 
 and VCode='17201' and
 WorkLocation in('Jamshedpur','Saraiekela');
