private void Fill_CC_WorkOrder()
{
    // Ensure both FormContainers have their rows created
    if (WorkOrder_Exemption_Record.Rows.Count == 0) return;
    if (Action_Record.Rows.Count == 0) return;

    // 1. Get WorkOrder textbox from first FormContainer
    TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0]
                      .FindControl("WorkOrderNo");

    // 2. Get CheckBoxList from second FormContainer
    CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0]
                          .FindControl("cc_wo");

    if (txtWO == null || chkWO == null) return;

    chkWO.Items.Clear();

    if (!string.IsNullOrWhiteSpace(txtWO.Text))
    {
        // Supports comma and | delimiter
        string[] arr = txtWO.Text.Split(
            new char[] { ',', '|' }, StringSplitOptions.RemoveEmptyEntries
        );

        foreach (string wo in arr)
        {
            chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
        }

        // Optional: select all by default
        foreach (ListItem li in chkWO.Items)
            li.Selected = true;
    }
}



protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    // Load dataset for selected record
    GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());

    // 1st FormContainer: WorkOrder details
    WorkOrder_Exemption_Record.BindData();

    // 2nd FormContainer: Action panel CC
    Action_Record.BindData();

    // Fill CheckBoxList with WorkOrder No(s)
    Fill_CC_WorkOrder();

    // Load remarks
    BL_WorkOrder_Exemption_Approval blobj = new BL_WorkOrder_Exemption_Approval();
    string ID = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString();

    DataSet ds = blobj.BindRemarks(ID);
    Remarks_grid.DataSource = ds.Tables[0];
    Remarks_grid.DataBind();

    btnSave.Visible = false;

    // Show/Hide sections
    WorkOrder_Exemption_Record.Visible = true;
    Action_Record.Visible = true;

    ((HtmlGenericControl)Action_Record.Rows[0].FindControl("div_exp_cc")).Visible = false;
    ((HtmlGenericControl)Action_Record.Rows[0].FindControl("div_newRemarks")).Visible = false;

    string status = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString();

    // Handle status
    if (status == "Approved")
    {
        WorkOrder_Exemption_Record.DataBind();
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
        ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = false;
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;

        Action_Record.Visible = false;
    }
    else if (status == "Pending With CC")
    {
        WorkOrder_Exemption_Record.DataBind();
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
        ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = false;
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;

        btnSave.Visible = true;
        Action_Record.Enabled = true;
    }
    else if (status == "Return")
    {
        WorkOrder_Exemption_Record.DataBind();
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
        ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = false;
        ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;

        btnSave.Visible = false;
        Action_Record.Visible = false;
    }
}
