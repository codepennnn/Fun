   BL_Half_Yearly blobj = new BL_Half_Yearly();
   DataSet dsExist = blobj.chkExist(vc, year, Period);
   bool isExist = dsExist != null && dsExist.Tables[0].Rows.Count > 0;

   if(isExist)
   {
       //string oldRef = dsExist.Tables[0].Rows[0]["RefNo"].ToString();
       //PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["RefNo"] = oldRef;
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


   bool result = Save();

   if (result)
   {
       string Ref_No = blobj.Get_Ref_No(PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ID"].ToString());




      System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Your Half Yearly Ref No. is: " + Ref_No + "');", true);

      PageRecordDataSet.Clear();
      HalfYearly_Records.BindData();
      btnSave.Visible = false;
      MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");



   }
   else
   {
       MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
   }


   when data alredy exist then my bool become false and showing error while saving
