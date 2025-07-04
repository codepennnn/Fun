
      pno in (123456,123457)
      
      public DataSet getgmail(string[] pno)
        {
            string strsql = string.Empty;
            strsql = "select EmailID from UserLoginDB.dbo.App_EmployeeMaster where pno in('@Pno')";
            Dictionary<string, object> objparam = new Dictionary<string, object>();
            objparam.Add("Pno",string.Join("','",pno));
            DataHelper dh = new DataHelper();
            return GetDataset1(strsql, "App_EmployeeMAster", objparam);

        }
