protected void Search_Click(object sender, EventArgs e)
{
    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string Period = SearchPeriod.SelectedValue;

    string fromdt, todt, wageMonth;

    if (Period == "Jan-June")
    {
        wageMonth = "1,2,3,4,5,6";
        fromdt = $"{year}-01-01";
        todt   = $"{year}-06-30";
    }
    else
    {
        wageMonth = "7,8,9,10,11,12";
        fromdt = $"{year}-07-01";
        todt   = $"{year}-12-31";
    }

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.GetData(vcode, fromdt, todt, Period, year, wageMonth);

    // ❗ CHECK IF DATA EXISTS
    if (ds == null || ds.Tables[0].Rows.Count == 0)
    {
        PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
        HalfYearly_Records.BindData();

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No data found. Please submit Half-Yearly entry first.");

        return;
    }

    // ✔ Data exists - bind it
    PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
    PageRecordDataSet.Merge(ds);
    HalfYearly_Records.BindData();
}
