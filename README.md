DECLARE @StartDate date = '2025-01-01';
DECLARE @EndDate   date = '2025-06-30';

-- Ensure Sunday = 1
SET DATEFIRST 7;

;WITH d AS (
    SELECT @StartDate AS dt
    UNION ALL
    SELECT DATEADD(DAY, 1, dt)
    FROM d
    WHERE dt < @EndDate
)
SELECT COUNT(*) AS Max_No_Contractor_Labour_
FROM d
WHERE DATEPART(WEEKDAY, dt) <> 1
OPTION (MAXRECURSION 0);

i want to add this in my main query and also set this parameter 

 SELECT NEWID() AS ID,l.LicNo AS LabourLicNo,l.FromDate,l.ToDate,l.workerno as License_Capacity,
                                CONVERT(varchar(10),

                                DATEDIFF(DAY, CONVERT(datetime, l.FromDate, 103), CONVERT(datetime, l.ToDate, 103))) AS Duration_Of_Contract,
                            (SELECT CONCAT(R.V_NAME, ', ', R.ADDRESS) FROM App_Vendor_Reg AS R WHERE R.V_CODE = l.VCode
                            ) AS Name_Address_Of_Contractor,

                            0.00 as Amount_Of_Wages_Paid_Children,



                            c3.wo_no As WorkOrderNo,
                           FORMAT (R.FROM_DATE,'dd/MM/yyyy' )as Workorder_FromDate,
                            FORMAT (R.TO_DATE,'dd/MM/yyyy' )as Workorder_ToDate,
                            

                         
                            (SELECT top 1 COUNT(DISTINCT w.AadharNo) FROM App_Wagesdetailsjharkhand AS w
                                INNER JOIN App_EmployeeMaster AS em
                                    ON em.AadharCard = w.AadharNo AND em.Sex = 'M'
                                WHERE w.workorderno = '4700024815'
                                  AND w.vendorcode = '17201'
                        AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                  AND w.yearwage = '2025'
                                  group by MonthWage
                            order by COUNT(DISTINCT w.AadharNo) desc
                            ) AS sex_M,

                            (SELECT top 1 COUNT(DISTINCT w.AadharNo) FROM App_Wagesdetailsjharkhand AS w
                                INNER JOIN App_EmployeeMaster AS em
                                    ON em.AadharCard = w.AadharNo AND em.Sex = 'F'
                                WHERE w.workorderno = '4700024815'
                                  AND w.vendorcode = '17201'
                                  AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                  AND w.yearwage = '2025'
                                  group by MonthWage
                            order by COUNT(DISTINCT w.AadharNo) desc
                            ) AS sex_F,

              
                            (SELECT ISNULL(SUM(tab.TotalMandays), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'M'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = '17201'
                                      AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                      AND w.yearwage = '2025'
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS No_Of_Mandays_Worked_Men,

                            (SELECT ISNULL(SUM(tab.TotalMandays), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'F'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = '17201'
                                      AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                      AND w.yearwage = '2025'
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS No_Of_Mandays_Worked_Women,
                                

                                       
                                     

                       
                            (SELECT ISNULL(SUM(tab.Male_Deduction), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Male_Deduction
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'M'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = '17201'
                                      AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                      AND w.yearwage = '2025'
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amt_Of_Deduct_From_Wages_Men,

                            (SELECT ISNULL(SUM(tab.Female_Deduction), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Female_Deduction
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'F'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = '17201'
                                      AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                      AND w.yearwage = '2025'
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amt_Of_Deduct_From_Wages_Women,


                                   
                                   

                          
                            (SELECT ISNULL(SUM(tab.Male_Gross), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Male_Gross
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'M'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = '17201'
                                      AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                      AND w.yearwage = '2025'
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amount_Of_Wages_Paid_Men,

                            (SELECT ISNULL(SUM(tab.Female_Gross), 0) FROM (SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Female_Gross
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'F'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = '17201'
                                    AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ' 1,2,3,4,5,6 ') > 0
                                      AND w.yearwage = '2025'
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amount_Of_Wages_Paid_Women,




          ( select Name_Address_Of_Establishment from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Name_Address_Of_Establishment ,


          ( select Name_and_Address_Of_PrincipalEmp from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Name_and_Address_Of_PrincipalEmp ,

           ( select Weekly_Holiday from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Weekly_Holiday ,


           ( select Status from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Status ,


          ( select State from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as State ,
                          
                                          ( select Welfare_Canteen from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Welfare_Canteen ,


             ( select Welfare_RestRoom from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Welfare_RestRoom ,

            ( select Welfare_DrinkingWater from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Welfare_DrinkingWater ,


 

                                          ( select Welfare_Creches from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Welfare_Creches ,


           ( select Welfare_FirstAid from App_Half_Yearly_Details where Year='2025' 
        and Period='Jan-June' and VCode='17201' and c3.wo_no=WorkOrderNo ) as Welfare_FirstAid 






                        FROM App_LabourLicenseSubmission AS l
                        LEFT JOIN App_vendor_form_c3_dtl AS c3
                            ON c3.ll_no = l.LicNo

                            left join App_WorkOrder_Reg R 
                            on c3.WO_NO=R.WO_NO
                        WHERE
                            c3.status = 'Approved'
                            AND l.FromDate < '2025-06-30 00:00:00.000'
                            AND l.ToDate >='2025-01-01 00:00:00.000'
                            AND l.VCode = '17201'
                            AND l.WorkLocation IN ('Jamshedpur', 'Saraiekela');



  int year = Convert.ToInt32(Year.SelectedValue);
 string month = SearchPeriod.SelectedValue.ToString();
 string fromdt = "";
 string todt = "";
 string wageMonth = "";
 


 if (month == "Jan-June")
 {
    wageMonth = "1,2,3,4,5,6";
    fromdt = new DateTime(year, 1, 1).ToString("yyyy-MM-dd");
     todt = new DateTime(year, 6, 30).ToString("yyyy-MM-dd");
 }
 else
 {
     wageMonth = "7,8,9,10,11,12";
     fromdt = new DateTime(year, 7, 1).ToString("yyyy-MM-dd");
     todt = new DateTime(year, 12, 31).ToString("yyyy-MM-dd");
 }
 string vcode = Session["UserName"].ToString();
 string Period = SearchPeriod.SelectedValue;
 ds = blobj.GetData(vcode, fromdt, todt, Period, year, wageMonth);
