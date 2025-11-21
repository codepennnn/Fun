DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];
Guid masterID = Guid.Parse(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString());

if (remarksTable.Rows.Count == 0)
{
    DataRow newRow = remarksTable.NewRow();

    // 🔥 MUST BE FIRST — OR DataSet throws "column does not allow nulls"
    newRow["ID"] = Guid.NewGuid();    

    // now the rest
    newRow["MASTER_ID"] = masterID;
    newRow["Remarks"] = NewRemarks.Text;
    newRow["CreatedOn"] = DateTime.Now;
    newRow["CreatedBy"] = Session["UserName"].ToString();

    // only now add the row
    remarksTable.Rows.Add(newRow);  
}
else
{
    remarksTable.Rows[0]["MASTER_ID"] = masterID;
    remarksTable.Rows[0]["Remarks"] = NewRemarks.Text;
    remarksTable.Rows[0]["CreatedOn"] = DateTime.Now;
    remarksTable.Rows[0]["CreatedBy"] = Session["UserName"].ToString();
}
