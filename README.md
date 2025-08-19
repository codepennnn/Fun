
        protected void Block_unblock_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_Unblock")).SelectedValue;

            Dictionary<string, object> ddlParams = new Dictionary<string, object>();
            ddlParams.Add("type", ((TextBox)sender).Text);
            GetDropdowns("Reason", ddlParams);
            Reason.DataBind();

        }
DDLQuery.Add("RFQ_Reason", "select 'Please Select' as Reason,0 as ord nunion select REASON as Reason,1 as ord  from VENDORUNBLOCKREASON where TYPE = @type order by ord");
