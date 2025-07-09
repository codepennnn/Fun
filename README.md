  select  CONVERT(varchar(20),GETDATE(),103) as  TODAY_DATE, dtl.V_NAME,dtl.V_NAME ,dtl.V_CODE,dtl.WO_NO,  CONVERT(varchar(20),dtl.PERIOD_CONTRACT_TO,103) as  PERIOD_CONTRACT_TO ," + ll_worker+ " as LL_WORKER,dtl.LL_VALID_UPTO,dtl.LOCATION_OF_WORK,dtl.NATURE_OF_PAYMENT,dtl.AUTHOR_NAME,dtl.AUTHOR_CONTACT_NO,(select sum(NO_OF_EMP_REG)+sum(NO_OF_EMP_TEMP)  from App_Vendor_FormC3_WorkManCat as cat where cat.MASTER_ID=dtl.ID and cat.WO_NO = dtl.WO_NO and cat.MASTER_ID=dtl.id) as Total_SUM,dtl.FORMC3_REFNO from App_Vendor_form_C3_Dtl as dtl where dtl.WO_NO='" + wo_no + "' and   ll_no='" + ll_no + "'   and dtl.V_CODE='" + v_code+"' and dtl.STATUS='Approved'    ";



    string ll_worker = "";
  ds2 = blobj.Getc3_ll_work(wo_no, v_code);
  if (ds2.Tables[0].Rows.Count > 0)
  {
      if (ds2.Tables[0].Rows[0]["LL_WORKER"].ToString() == "" || ds2.Tables[0].Rows[0]["LL_WORKER"].ToString() == null)
      {
          ds3 = blobj.Getc3_jusco_ll_work(wo_no, v_code);
          if (ds3.Tables[0].Rows.Count > 0)
          {
              if (ds3.Tables[0].Rows[0]["LL_WORKER"].ToString() == "" || ds3.Tables[0].Rows[0]["LL_WORKER"].ToString() == null)
              {
                  ll_worker = "ERROR";
              }
              else
              {
                  ll_worker = ds3.Tables[0].Rows[0]["LL_WORKER"].ToString();
              }
          }
      }
      else 
      {
          ll_worker = ds2.Tables[0].Rows[0]["LL_WORKER"].ToString();
      }
  }
  ds1 = blobj.Getc3_report(wo_no,v_code, ll_worker,ll_no);
      ReportViewer1.LocalReport.ReportPath = "App\\Report\\FormC3_Report.rdlc";
            
