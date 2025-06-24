 protected void BtnSave_Click(object sender, EventArgs e)
 {

     AttendanceSupplementRecords.UnbindData();



     int i, blank_chk = 0;
     for (i = 0; i < PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows.Count; i++)
     {
         if (PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i].RowState.ToString() != "Deleted")
         {
             PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["Status"] = "Pending for approval";
             if (PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["Present"].ToString() == "" || PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["Present"].ToString() == null)
             {
                 PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["Present"] = "false";
             }


             if (PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["SiteID"].ToString() == "" || PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["SiteID"].ToString() == null || PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["LocationCode"].ToString() == "" || PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["LocationCode"].ToString() == null || PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["WorkOrderNo"].ToString() == "" || PageRecordDataSet.Tables["App_AttendanceDetailsSupplement"].Rows[i]["WorkOrderNo"].ToString() == null)
             {
                 blank_chk = 1;

             }


         }
     }
