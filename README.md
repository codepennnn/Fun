  BL_WageComplience_Approval blobj = new BL_WageComplience_Approval();
  string strmonth = Wage_ComplienceRecords.SelectedDataKey.Values[0].ToString();
  string vcode = Wage_ComplienceRecords.SelectedDataKey.Values[1].ToString();
  DataSet ds_att = new DataSet();
  DataSet ds_tot = new DataSet();
  ds_att = blobj.getattdancedata(vcode, strmonth, strmonth);


 

  ds_att.Tables[0].PrimaryKey = new DataColumn[] { ds_att.Tables[0].Columns["WorkManSLNo"], ds_att.Tables[0].Columns["WorkManName"], ds_att.Tables[0].Columns["Eng_Type"], ds_att.Tables[0].Columns["Month"], ds_att.Tables[0].Columns["Year"] };
 
  
  ds_tot = blobj.gettot(vcode, strmonth, strmonth);
      

  ds_tot.Tables[0].PrimaryKey = new DataColumn[] { ds_tot.Tables[0].Columns["WorkManSLNo"], ds_tot.Tables[0].Columns["WorkManName"], ds_tot.Tables[0].Columns["Eng_Type"], ds_tot.Tables[0].Columns["Month"], ds_tot.Tables[0].Columns["Year"] };

  ds_att.Merge(ds_tot, true, MissingSchemaAction.AddWithKey);

  BL_WageComplience_Approval blobj = new BL_WageComplience_Approval();
  string strmonth = Wage_ComplienceRecords.SelectedDataKey.Values[0].ToString();
  string vcode = Wage_ComplienceRecords.SelectedDataKey.Values[1].ToString();
  DataSet ds_att = new DataSet();
  DataSet ds_tot = new DataSet();
  ds_att = blobj.getattdancedata(vcode, strmonth, strmonth);


 

  ds_att.Tables[0].PrimaryKey = new DataColumn[] { ds_att.Tables[0].Columns["WorkManSLNo"], ds_att.Tables[0].Columns["WorkManName"], ds_att.Tables[0].Columns["Eng_Type"], ds_att.Tables[0].Columns["Month"], ds_att.Tables[0].Columns["Year"] };
 
  
  ds_tot = blobj.gettot(vcode, strmonth, strmonth);
      

  ds_tot.Tables[0].PrimaryKey = new DataColumn[] { ds_tot.Tables[0].Columns["WorkManSLNo"], ds_tot.Tables[0].Columns["WorkManName"], ds_tot.Tables[0].Columns["Eng_Type"], ds_tot.Tables[0].Columns["Month"], ds_tot.Tables[0].Columns["Year"] };

  ds_att.Merge(ds_tot, true, MissingSchemaAction.AddWithKey);

