int[] months;

if (Period == "Jan-June")
    months = new int[] { 1, 2, 3, 4, 5, 6 };
else
    months = new int[] { 7, 8, 9, 10, 11, 12 };

string monthList = string.Join(",", months);

DataSet ds = blobj.GetData(vcode, fromdt, todt, Period, year, monthList);

PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
PageRecordDataSet.Merge(ds);
HalfYearly_Records.BindData();
