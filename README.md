
        protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
        {
            string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;
            TextBox txtStatus = (TextBox)row.FindControl("Status");

           
            string type = reason.SelectedValue;

            if (type == "RFQ_B")
            {
                txtStatus.Text = "RFQ_B"; // Block
            }
            else if (type == "RFQ_U")
            {
                txtStatus.Text = "RFQ_U"; // Unblock
            }
            else
            {
                txtStatus.Text = ""; 
            }

            txtStatus.Visible = true;
        }

