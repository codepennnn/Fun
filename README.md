       protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
       {
           string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;
           BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
           DataSet ds = new DataSet();
           ds = blobj.GetStatus(reason);
           if (ds.Tables[0].Rows.Count > 0)
           {
               ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status")).Text = ds.Tables[0].Rows[0]["Type"].ToString();
           }
       }

        public DataSet GetStatus(string reason)
 {
     string strSQL = "select Type from VENDORUNBLOCKREASON where Reason ='" + reason + "'";
     Dictionary<string, object> objParam = new Dictionary<string, object>();
     objParam.Add("Reason", reason);
     DataHelper dh = new DataHelper();
     return dh.GetDataset(strSQL, "VENDORUNBLOCKREASON", objParam);
 }

 i want add one more condtion to match with R_ID
