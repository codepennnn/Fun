// Insert into App_WorkOrder_exemption_remarks table using PageRecordDataSet
DataRow dr = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].NewRow();

dr["CreatedOn"] = System.DateTime.Now;
dr["CreatedBy"] = Session["UserName"].ToString();
dr["Remarks"] = Remarks_CC;
dr["MASTER_ID"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"];

// If you want to save attachment for remark (optional):
// dr["Attachment"] = "";

// Add row into dataset table
PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].Rows.Add(dr);
