  if (ds5.Tables[0].Rows.Count > 0)
  {
      ds4 = blobj.get_wage_gen(Session["UserName"].ToString(), datestart, dateend, month, YearWage);
      if (ds4.Tables[0].Rows.Count > 0)
      {
          string loc = "";
          for (int h = 0; h < ds4.Tables[0].Rows.Count; h++)
          {
              loc = loc + ds4.Tables[0].Rows[h]["Location"].ToString() + " , ";
          }

          msg = "Wage generation against location " + loc + " is not submitted . Kindly generate it from Attendance cum Wage Generation";
          ScriptManager.RegisterStartupScript(this, GetType(), "Validate_stat", "Validate_stat('" + msg + "');", true);
      }
      else
      {

          DataSet ds2 = new DataSet();
          DataSet ds3 = new DataSet();
          DataSet ds_nilchk = new DataSet();

          ds2 = blobj.active_nil_wo(Session["UserName"].ToString(), YearWage, month);
          if (ds2.Tables[0].Rows.Count > 0)
          {
              for (int i = 0; i < ds2.Tables[0].Rows.Count; i++)
              {
                  ds3 = blobj.active_nil_wo_no_work(ds2.Tables[0].Rows[i]["WorkOrderNo"].ToString());
                  if (ds3.Tables[0].Rows.Count > 0)
                  {
                      if (ds3.Tables[0].Rows[0]["NO_WORK"].ToString() == "Temporary")
                      {
                          string year = ds3.Tables[0].Rows[0]["TEMPORARY_YEAR"].ToString();
                          string months = ds3.Tables[0].Rows[0]["TEMPORARY_MONTH"].ToString();

                          if (year == YearWage)
                          {
                              String[] strlist = months.Split(',');

                              for (int k = 0; k < strlist.Length; k++)
                              {
                                  string pad_month = strlist[k].ToString();
                                  if (month == pad_month)
                                  {
                                      msg = ds2.Tables[0].Rows[i]["WorkOrderNo"].ToString() + " this work order is present in Nil Work Order , so can not process Wage Compliance. please correct it in employee attendance and wage generation !!!";
                                      ScriptManager.RegisterStartupScript(this, GetType(), "alert", "display_msg('" + msg + "');", true);
                                      display = "N";
                                      break;
                                  }
                                  else
                                      display = "Y";
                              }

                          }
                          else
                          {
                              display = "Y";
                          }

                      }
                      else if (ds3.Tables[0].Rows[0]["NO_WORK"].ToString() == "Permanent")
                      {
                          string months = ds3.Tables[0].Rows[0]["CLOSER_DATE"].ToString();

                          string year = ds3.Tables[0].Rows[0]["TEMPORARY_YEAR"].ToString();

                          if (Convert.ToInt32(YearWage) > Convert.ToInt32(year))
                          {
                              msg = ds2.Tables[0].Rows[i]["WorkOrderNo"].ToString() + " this work order is present in Nil Work Order , so can not process Wage Compliance. please correct it in employee attendance and wage generation !!!";
                              ScriptManager.RegisterStartupScript(this, GetType(), "alert", "display_msg('" + msg + "');", true);
                              display = "N";
                              break;
                          }
                          else if (Convert.ToInt32(YearWage) == Convert.ToInt32(year))
                          {
                              if (Convert.ToInt32(month) >= Convert.ToInt32(months))
                              {
                                  msg = ds2.Tables[0].Rows[i]["WorkOrderNo"].ToString() + " this work order is present in Nil Work Order , so can not process Wage Compliance. please correct it in employee attendance and wage generation !!!";
                                  ScriptManager.RegisterStartupScript(this, GetType(), "alert", "display_msg('" + msg + "');", true);
                                  display = "N";
                                  break;
                              }
                              else
                                  display = "Y";

                          }
                          else
                              display = "Y";



                      }
                      else
                          display = "Y";

                  }
                  else
                      display = "Y";


              }

          }
          else
              display = "Y";




          // BL_WageComplience blobj = new BL_WageComplience();




          if (display == "Y")
          {

              DataSet ds1 = new DataSet();
              //ds1 = blobj.chk_wo_no_Data(d_day, Session["UserName"].ToString(), YearWage, month);
              ds1 = blobj.chk_wo_no_Data(d_day, d_day_end, Session["UserName"].ToString(), YearWage, month);
              string unmatched_wo = "";
              if (ds1.Tables[0].Rows.Count > 0)
              {
                  for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                  {
                      unmatched_wo = unmatched_wo + "," + ds1.Tables[0].Rows[j]["WO_NO"].ToString();
                  }

              }

              if (unmatched_wo != "")
              {
                  String[] list_wo = unmatched_wo.Split(',');
                  for (int h = 0; h < list_wo.Length; h++)
                  {
                      ds_nilchk = blobj.active_nil_wo_no_work(list_wo[h].ToString());
                      if (ds_nilchk.Tables[0].Rows.Count > 0)
                      {
                          for (int l = 0; l < ds_nilchk.Tables[0].Rows.Count; l++)
                          {

                              if (ds_nilchk.Tables[0].Rows[l]["NO_WORK"].ToString() == "Temporary")
                              {
                                  string year = ds_nilchk.Tables[0].Rows[l]["TEMPORARY_YEAR"].ToString();
                                  string months = ds_nilchk.Tables[0].Rows[l]["TEMPORARY_MONTH"].ToString();

                                  if (year == YearWage)
                                  {
                                      String[] strlist = months.Split(',');

                                      for (int k = 0; k < strlist.Length; k++)
                                      {
                                          string pad_month = strlist[k].ToString();
                                          if (month == pad_month)
                                          {
                                              unmatched_wo = unmatched_wo.Replace(list_wo[h].ToString(), "");

                                              break;
                                          }


                                      }

                                  }


                              }
                              else if (ds_nilchk.Tables[0].Rows[l]["NO_WORK"].ToString() == "Permanent")
                              {
                                  string months = ds_nilchk.Tables[0].Rows[l]["CLOSER_DATE"].ToString();

                                  string year = ds_nilchk.Tables[0].Rows[l]["TEMPORARY_YEAR"].ToString();

                                  if (Convert.ToInt32(YearWage) > Convert.ToInt32(year))
                                  {
                                      unmatched_wo = unmatched_wo.Replace(list_wo[h].ToString(), "");
                                      //break;
                                  }
                                  else if (Convert.ToInt32(YearWage) == Convert.ToInt32(year))
                                  {
                                      if (Convert.ToInt32(month) >= Convert.ToInt32(months))
                                      {
                                          unmatched_wo = unmatched_wo.Replace(list_wo[h].ToString(), "");
                                          // break;
                                      }


                                  }


                              }




                          }



                      }



                  }


              }

              unmatched_wo = unmatched_wo.Replace(",", "");

              if (unmatched_wo != "")
              {


                  msg = unmatched_wo + " this work order is missing in Attendance , so can not process Wage Compliance. please correct it in employee attendance and wage generation !!!";
                  ScriptManager.RegisterStartupScript(this, GetType(), "alert", "display_msg('" + msg + "');", true);
              }
