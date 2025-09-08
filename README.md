   if (result)
            {
                DataSet ds1 = new DataSet();
                BL_LabourApproval blobj1 = new BL_LabourApproval();
                string licNo = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LicNo"].ToString();
                DateTime validityToDate = Convert.ToDateTime(PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["ToDate"]);
                ds1 = blobj1.UpdateLicenseValidity(licNo, validityToDate);

                //   after this one more update function for c3 closer date. fetch forech record according to licno then update c3closerdate which min from 
                //between min(PERIOD_CONTRACT_TO,LL_VALID_UPTO) 
   public DataSet UpdateLicenseValidity(string licNo, DateTime validityToDate)
        {
            string strSQL = "UPDATE App_Vendor_form_C3_Dtl SET LL_VALID_UPTO = @ToDate WHERE LicNo = @LicNo";

            Dictionary<string, object> objParam = new Dictionary<string, object>();
            objParam.Add("@ToDate", validityToDate);
            objParam.Add("@LicNo", licNo);

            DataHelper dh = new DataHelper();
            return dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
        }



        public DataSet UpdateC3CloserValidity(string licNo, DateTime lowestvalidity)
        {

            string strSQL = @"UPDATE App_Vendor_form_C3_Dtl SET C3CloserDate = ''  LicNo = @LicNo ";


            Dictionary<string, object> objParam = new Dictionary<string, object>();
            objParam.Add("@", lowestvalidity);
            objParam.Add("@LicNo", licNo);

            DataHelper dh = new DataHelper();
            return dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
        }
