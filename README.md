string Remarks_CC = NewRemarks.Text;

// ensure row exists
DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];

if (remarksTable.Rows.Count == 0)
{
    DataRow newRow = remarksTable.NewRow();
    newRow["MASTER_ID"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"];
    remarksTable.Rows.Add(newRow);
}

// now safe to write
remarksTable.Rows[0]["Remarks"] = Remarks_CC;
remarksTable.Rows[0]["CreatedOn"] = DateTime.Now;
remarksTable.Rows[0]["CreatedBy"] = Session["UserName"].ToString();
remarksTable.Rows[0]["MASTER_ID"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"];
