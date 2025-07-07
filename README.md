     public DataSet Get_Vendor_Details(string strId, String ID)
     {
         string strSQL = "select convert(uniqueidentifier,'" + ID + "') as ID,v.V_CODE,v.V_NAME,v.PF_CODE_NUMBER as PF_CODE," +
             " v.ESI_CODE_NUMBER as ESI_CODE, v.ADDRESS AS ADDRESS, v.OWNER_NAME AS OWNER_NAME, v.PHONE_NO AS PHONE_NO, v.EMAIL AS EMAIL_ID," +
             " r.NAME as AUTHOR_NAME,r.EMAIL as AUTHOR_EMAIL,r.CONTACT_NO as AUTHOR_CONTACT_NO ,r.ADHAR_CARD as AUTHOR_ADHAR_NUMBER,r.ADDRESS as AUTHOR_ADDRESS" +
             " from App_Vendor_Reg v" +
             " inner join App_Vendor_Representative r on r.MASTER_ID= v.ID" +
             " where v.ID =@ID";
         Dictionary<string, object> objParam = new Dictionary<string, object>();
         objParam.Add("ID", strId);
         DataHelper dh = new DataHelper();
         return dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
     }
