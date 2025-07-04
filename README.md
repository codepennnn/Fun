     public DataSet Getc3_report(string wo_no,string v_code,string ll_worker)
     {
         string strSQL = "  select  CONVERT(varchar(20),GETDATE(),103) as  TODAY_DATE, dtl.V_NAME,dtl.V_CODE,dtl.WO_NO,  CONVERT(varchar(20),dtl.PERIOD_CONTRACT_TO,103) as  PERIOD_CONTRACT_TO ,"+ll_worker+" as LL_WORKER,dtl.LL_VALID_UPTO,dtl.LOCATION_OF_WORK,dtl.NATURE_OF_PAYMENT,dtl.AUTHOR_NAME,dtl.AUTHOR_CONTACT_NO,(select sum(NO_OF_EMP_REG)+sum(NO_OF_EMP_TEMP)  from App_Vendor_FormC3_WorkManCat as cat where cat.MASTER_ID=dtl.ID and cat.WO_NO = dtl.WO_NO ) as Total_SUM,dtl.FORMC3_REFNO from App_Vendor_form_C3_Dtl as dtl where dtl.WO_NO='" + wo_no + "' and dtl.V_CODE='"+v_code+"' and dtl.STATUS='Approved'    "; /*and C.C3_CLOSER_DATE > getdate()*/ /* after insert closer date add this filter in query */
         Dictionary<string, object> objParam = new Dictionary<string, object>();
         objParam.Add("WO_NO", wo_no);
         DataHelper dh = new DataHelper();
         DataSet ds = new DataSet();
         ds = dh.GetDataset(strSQL, "DataSet1", objParam);
         return ds;
     }
