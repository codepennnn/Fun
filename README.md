  else
  {
      DataSet ds = new DataSet();
      DataSet ds1 = new DataSet();
      ds = blobj.GetDelete(vc, year, Period);

   ds1 = blobj.Generate_Global_RefNo("HALFYEARLY");
      string refNo = ds1.ToString();

      if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].RowState == DataRowState.Modified)
      {

          for (int i = 0; i < PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Count; i++)
          {
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["VCode"] = Session["Username"].ToString();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Year"] = Year.SelectedValue;
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Period"] = SearchPeriod.SelectedValue;
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["RefNo"]; = refNo;
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].AcceptChanges();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].SetAdded();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedBy"] = Session["UserName"].ToString();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedOn"] = System.DateTime.Now;

          }


      }
  }


       public DataSet Generate_Global_RefNo(string objName)

     {
         string refNo = "";
         string prefix = "", postfix = "";
         int number = 0, padding = 5;

         string strSQL = @"SELECT Prefix, Postfix, number, leftpadding FROM App_Sys_AutoNumber WHERE ObjName = @obj";

         Dictionary<string, object> objParam = new Dictionary<string, object>();

         objParam.Add("objName", objName);
     

         DataHelper dh = new DataHelper();
         DataSet ds = dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
         return ds;
     }
