
        bool DelResult = DeleteRelatedRecords(mn, yr, VCode, active_wo_no, location_code);

                for (int i = 0; i < PageRecordDataSet.Tables[0].Rows.Count; i++)
                {
                    if (PageRecordDataSet.Tables["App_WagesDetailsJharkhand"].Rows[i].RowState.ToString() != "Deleted")
                    {
                        PageRecordDataSet.Tables[0].Rows[i].AcceptChanges();
                        PageRecordDataSet.Tables[0].Rows[i].SetAdded();

                    }

                }




                bool result = Save();




      public bool DeleteRelatedRecords(string mn, string yr, string VCode, string WorkOrderno,string locationcode)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connect"].ConnectionString);
            con.Open();

            string strSQL = "Delete from App_WagesDetailsJharkhand " +
                " where YearWage = '" + yr + "' and MonthWage = '" + mn + "' " +
                " and VendorCode = '" + VCode + "' and WorkOrderNo IN (" + WorkOrderno + ") and LocationCode='"+ locationcode + "'      ";

            SqlCommand cmd = new SqlCommand(strSQL, con);
            cmd.ExecuteNonQuery();
            return true;
        }


https://wphtml.com/html/tf/duralux-demo/analytics.html
