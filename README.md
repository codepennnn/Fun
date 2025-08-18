     protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
     {
      
         DropDownList ddlBlockUnblock = (DropDownList)FindControl("Reason");
         TextBox txtStatus = (TextBox)FindControl("Status");
         DataSet ds = new DataSet();
         if (ddlBlockUnblock != null && txtStatus != null)
         {
             string type = ddlBlockUnblock.SelectedValue;

             if (type == "RFQ_B")      
             {
                 txtStatus.Text = "RFQ_B";
             }
             else if (type == "RFQ_U") 
             {
                 txtStatus.Text = "RFQ_U";
             }
             else
             {
                 txtStatus.Text = "";
             }

             txtStatus.Visible = true;
         }
         if (ds.Tables[0].Rows.Count > 0)
         {
             ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status")).Text = ds.Tables[0].Rows[0]["Type"].ToString();
         }
     }
