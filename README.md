    protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
        WorkOrder_Exemption_Records.SelectedIndex = -1;
        WorkOrder_Exemption_Record.BindData();
        DivInputFields.Visible = true;


        if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"] = "Approved";)
            {
            btnSave.Visible = false;
           }
        else
        {
            btnSave.Visible = true;
        }

    }
