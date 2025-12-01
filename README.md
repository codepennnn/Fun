   protected void Search_Click(object sender, EventArgs e)
   {
       btnSave.Visible = true;
       BL_Half_Yearly blobj = new BL_Half_Yearly();
       DataSet ds = new DataSet();
       


       //string strKey = Session["Username"].ToString() + "," + Year.SelectedValue + "," + SearchPeriod.SelectedValue;
       //GetRecord(strKey);
      // if(PageRecordDataSet.Tables[0].Rows.Count>0)
      // { 
       //  HalfYearly_Records.DataBind();     
           //PageRecordDataSet.Merge(ds);
     // }
     // else
     // {
           int year = Convert.ToInt32(Year.SelectedValue);
           string month = SearchPeriod.SelectedValue.ToString();
           string fromdt = "";
           string todt = "";
           if (month == "Jan-June")
           {
               fromdt = new DateTime(year, 1, 1).ToString("yyyy-MM-dd");
               todt = new DateTime(year, 6, 30).ToString("yyyy-MM-dd");
           }
           else
           {
               fromdt = new DateTime(year, 7, 1).ToString("yyyy-MM-dd");
               todt = new DateTime(year, 12, 31).ToString("yyyy-MM-dd");
           }
           string vcode = Session["UserName"].ToString();
           string Period = SearchPeriod.SelectedValue;
           ds = blobj.GetData(vcode, fromdt, todt, Period, year);

          
           PageRecordDataSet.Merge(ds);
           HalfYearly_Records.BindData();
     // }


       
   }


           public DataSet GetData(string vcode, string fromdt, string todt,string Period,int year)
        {
            Dictionary<string, object> objParam = new Dictionary<string, object>();
            DataHelper dh = new DataHelper();
            // string strSQL = "SELECT newid() as ID,LicNo as LabourLicNo,FromDate,ToDate FROM App_LabourLicenseSubmission  WHERE  Vcode = @Vcode";

            //string strSQL = " SELECT newid() as ID,LicNo as LabourLicNo,FromDate,ToDate FROM App_LabourLicenseSubmission  WHERE  " +
            //" FromDate < @FromDate AND ToDate >= @ToDate and WorkLocation in ('Jamshedpur', 'Seraikela') and Vcode = @Vcode";

            //string strSQL = "SELECT newid() as ID,LicNo as LabourLicNo,FromDate,ToDate,convert(varchar(10),DATEDIFF(DAY, convert(datetime,FromDate,103), " +
            //    "convert(datetime,ToDate,103))) AS Duration_Of_Contract,(select concat (V_NAME,', ',ADDRESS) from App_Vendor_Reg R where R.V_CODE=Vcode) as Name_Address_Of_Contractor" +
            //    " FROM App_LabourLicenseSubmission  WHERE   FromDate < @FromDate AND ToDate >= @ToDate and VCode=@Vcode and WorkLocation in('Jamshedpur','Saraiekela')";



            string strSQL = @"
                        SELECT NEWID() AS ID,l.LicNo AS LabourLicNo,l.FromDate,l.ToDate,
                                CONVERT(varchar(10),

                             
                            
                                


        
                                DATEDIFF(DAY, CONVERT(datetime, l.FromDate, 103), CONVERT(datetime, l.ToDate, 103))) AS Duration_Of_Contract,
                            (SELECT CONCAT(R.V_NAME, ', ', R.ADDRESS) FROM App_Vendor_Reg AS R WHERE R.V_CODE = l.VCode
                            ) AS Name_Address_Of_Contractor,


                                




                            c3.wo_no As WorkOrderNo,

                         
                            (SELECT COUNT(DISTINCT w.AadharNo) FROM App_Wagesdetailsjharkhand AS w
                                INNER JOIN App_EmployeeMaster AS em
                                    ON em.AadharCard = w.AadharNo AND em.Sex = 'M'
                                WHERE w.workorderno = c3.wo_no
                                  AND w.vendorcode = @Vcode
                                  AND w.monthwage IN (1,2,3,4,5,6)
                                  AND w.yearwage = @year
                            ) AS sex_M,

                            (SELECT COUNT(DISTINCT w.AadharNo) FROM App_Wagesdetailsjharkhand AS w
                                INNER JOIN App_EmployeeMaster AS em
                                    ON em.AadharCard = w.AadharNo AND em.Sex = 'F'
                                WHERE w.workorderno = c3.wo_no
                                  AND w.vendorcode = @Vcode
                                  AND w.monthwage IN (1,2,3,4,5,6)
                                  AND w.yearwage = @year
                            ) AS sex_F,

              
                            (SELECT ISNULL(SUM(tab.TotalMandays), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'M'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = @Vcode
                                      AND w.monthwage IN (1,2,3,4,5,6)
                                      AND w.yearwage = @year
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS No_Of_Mandays_Worked_Men,

                            (SELECT ISNULL(SUM(tab.TotalMandays), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'F'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = @Vcode
                                      AND w.monthwage IN (1,2,3,4,5,6)
                                      AND w.yearwage = @year
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS No_Of_Mandays_Worked_Women,
                                

                                       
                                     

                       
                            (SELECT ISNULL(SUM(tab.Male_Deduction), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Male_Deduction
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'M'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = @Vcode
                                      AND w.monthwage IN (1,2,3,4,5,6)
                                      AND w.yearwage = @year
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amt_Of_Deduct_From_Wages_Men,

                            (SELECT ISNULL(SUM(tab.Female_Deduction), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Female_Deduction
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'F'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = @Vcode
                                      AND w.monthwage IN (1,2,3,4,5,6)
                                      AND w.yearwage = @year
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amt_Of_Deduct_From_Wages_Women,


                                   
                                   

                          
                            (SELECT ISNULL(SUM(tab.Male_Gross), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Male_Gross
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'M'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = @Vcode
                                      AND w.monthwage IN (1,2,3,4,5,6)
                                      AND w.yearwage = @year
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amount_Of_Wages_Paid_Men,

                            (SELECT ISNULL(SUM(tab.Female_Gross), 0) FROM (SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Female_Gross
                                    FROM app_wagesdetailsjharkhand AS w
                                    INNER JOIN app_employeemaster AS em
                                        ON em.aadharcard = w.aadharno AND em.sex = 'F'
                                    WHERE w.workorderno = c3.wo_no
                                      AND w.vendorcode = @Vcode
                                      AND w.monthwage IN (1,2,3,4,5,6)
                                      AND w.yearwage = @year
                                    GROUP BY w.AadharNo
                                ) AS tab
                            ) AS Amount_Of_Wages_Paid_Women,




  ( select Name_Address_Of_Establishment from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Name_Address_Of_Establishment ,


  ( select Name_and_Address_Of_PrincipalEmp from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Name_and_Address_Of_PrincipalEmp ,

   ( select Weekly_Holiday from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Weekly_Holiday ,


   ( select Status from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Status ,


  ( select State from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as State ,
                          
                                  ( select Welfare_Canteen from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Welfare_Canteen ,


     ( select Welfare_RestRoom from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Welfare_RestRoom ,

    ( select Welfare_DrinkingWater from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Welfare_DrinkingWater ,


 

                                  ( select Welfare_Creches from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Welfare_Creches ,


   ( select Welfare_FirstAid from App_Half_Yearly_Details where Year=@year 
and Period=@Period and VCode=@Vcode and c3.wo_no=WorkOrderNo ) as Welfare_FirstAid 






                        FROM App_LabourLicenseSubmission AS l
                        LEFT JOIN App_vendor_form_c3_dtl AS c3
                            ON c3.ll_no = l.LicNo
                        WHERE
                            c3.status = 'Approved'
                            AND l.FromDate < @ToDate
                            AND l.ToDate >= @FromDate
                            AND l.VCode = @Vcode
                            AND l.WorkLocation IN ('Jamshedpur', 'Saraiekela');";






            objParam.Add("Vcode", vcode); 
            objParam.Add("FromDate", todt);
            objParam.Add("ToDate", fromdt);
            objParam.Add("Period", Period);
            objParam.Add("year", year);
            DataSet ds = dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
            return ds;
        }
        
