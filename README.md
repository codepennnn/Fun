protected void BtnSearch_Click(object sender, EventArgs e)
{
    // 1. Clear old data
    PageRecordDataSet.Clear();
    PageRecordDataSet.EnforceConstraints = false;

    // 2. Create NEW row inside dataset (NOT using NewRecord here)
    DataRow newRow = PageRecordDataSet.Tables["App_HOD_Master"].NewRow();

    // 3. Assign selected dropdown values to new row
    newRow["Division"] = txtDivision.SelectedItem.Text;
    newRow["Department"] = txtDepartment.SelectedItem.Text;
    newRow["Section"] = txtSection.SelectedItem.Text;

    // 4. Add row to dataset
    PageRecordDataSet.Tables["App_HOD_Master"].Rows.Add(newRow);

    // 5. Bind to form container
    HOD_Record.DataBind();
}



protected void Page_Load(object sender, EventArgs e)
{
    HOD_Record.DataSource = PageRecordDataSet;

    if (!IsPostBack)
    {
        GetDropdowns("txtDivision");

        txtDivision.DataBind();
        txtDepartment.DataBind();
        txtSection.DataBind();
    }
}
