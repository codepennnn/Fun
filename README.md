protected void btnSearch_Click(object sender, EventArgs e)
{
    BL_Compliance_MIS blobj = new BL_Compliance_MIS();
    DataSet ds_L1 = new DataSet();

    string MonthSearch = Month.SelectedValue;
    string YearSearch = Year.SelectedValue;

    ds_L1 = blobj.GetContractorWorker(MonthSearch, YearSearch);

    if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
    {
        // Export dataset directly to CSV (no need for GridView binding)
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Mis_Summary_Dept_Report.csv");
        Response.ContentType = "text/csv";
        Response.Charset = "";

        using (StringWriter sw = new StringWriter())
        {
            // Write header
            for (int i = 0; i < ds_L1.Tables[0].Columns.Count; i++)
            {
                sw.Write(ds_L1.Tables[0].Columns[i].ColumnName);
                if (i < ds_L1.Tables[0].Columns.Count - 1)
                    sw.Write(",");
            }
            sw.Write(sw.NewLine);

            // Write data
            int rowIndex = 1;
            foreach (DataRow dr in ds_L1.Tables[0].Rows)
            {
                sw.Write(rowIndex + ","); // Serial No
                for (int i = 0; i < ds_L1.Tables[0].Columns.Count; i++)
                {
                    string cellData = dr[i].ToString().Replace(",", " "); // avoid breaking CSV
                    sw.Write(cellData);

                    if (i < ds_L1.Tables[0].Columns.Count - 1)
                        sw.Write(",");
                }
                sw.Write(sw.NewLine);
                rowIndex++;
            }

            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }
    else
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
    }
}
