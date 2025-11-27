  if(isExist)
  {
      string oldRef = dsExist.Tables[0].Rows[0]["RefNo"].ToString();
      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["RefNo"] = oldRef;
      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ResubmitedOn"] = System.DateTime.Now;
      //PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].AcceptChanges();

  }
  else
  { 
      DataSet ds = new DataSet();
      ds = blobj.GetDelete(vc, year, Period);

      if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].RowState == DataRowState.Modified)
      {

          for (int i = 0; i < PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Count; i++)
          {
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["VCode"] = Session["Username"].ToString();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Year"] = Year.SelectedValue;
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Period"] = SearchPeriod.SelectedValue;
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].AcceptChanges();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].SetAdded();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedBy"] = Session["UserName"].ToString();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedOn"] = System.DateTime.Now;

          }
          

      }
  }


  data add correctly but when exist not updating
