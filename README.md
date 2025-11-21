DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];
Guid masterID = Guid.Parse(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString());

if (remarksTable.Rows.Count == 0)
{
    DataRow newRow = remarksTable.NewRow();

    // Tell dataset to let SQL generate NEWID()
    newRow["ID"] = DBNull.Value;  

    // You MUST set MASTER_ID (GUID)
    newRow["MASTER_ID"] = masterID;

    newRow["Remarks"] = NewRemarks.Text;
    newRow["CreatedOn"] = DateTime.Now;
    newRow["CreatedBy"] = Session["UserName"].ToString();

    remarksTable.Rows.Add(newRow);
}
else
{
    // Update existing remarks row
    remarksTable.Rows[0]["MASTER_ID"] = masterID;
    remarksTable.Rows[0]["Remarks"] = NewRemarks.Text;
    remarksTable.Rows[0]["CreatedOn"] = DateTime.Now;
    remarksTable.Rows[0]["CreatedBy"] = Session["UserName"].ToString();
}
