 protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
 {
     string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;
     BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
     DataSet ds = new DataSet();
     string Type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_Unblock")).SelectedValue;
     //ds = blobj.GetStatus(reason);

     if (ds.Tables[0].Rows.Count > 0)
     {
         ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status")).Text = ds.Tables[0].Rows[0]["Type"].ToString();
     }
 }

 i want save type with selected type not 
