 int year = Convert.ToInt32(Year.SelectedValue);
 string month = SearchPeriod.SelectedValue.ToString();
 string fromdt = "";
 string todt = "";
 if (month == "Jan-June")
 {
 string wageMonth = ('1','2','3','4','5','6');
     fromdt = new DateTime(year, 1, 1).ToString("yyyy-MM-dd");
     todt = new DateTime(year, 6, 30).ToString("yyyy-MM-dd");
 }
 else
 {
 string wageMonth = ('7', '8', '9', '10', '11', '12');
 fromdt = new DateTime(year, 7, 1).ToString("yyyy-MM-dd");
     todt = new DateTime(year, 12, 31).ToString("yyyy-MM-dd");
 }
 string vcode = Session["UserName"].ToString();
 string Period = SearchPeriod.SelectedValue;
 ds = blobj.GetData(vcode, fromdt, todt, Period, year,wageMonth);
