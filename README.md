CREATE TABLE [dbo].[App_Sys_AutoNumber] (
    [ObjName]     VARCHAR (250) NOT NULL,
    [Prefix]      VARCHAR (50)  NULL,
    [Postfix]     VARCHAR (50)  NULL,
    [number]      INT           NULL,
    [leftpadding] INT           CONSTRAINT [DF_App_Sys_AutoNumber_leftpadding] DEFAULT ((5)) NOT NULL,
    [IsActive]    BIT           CONSTRAINT [DF_App_Sys_AutoNumber_IsActive] DEFAULT ((1)) NOT NULL,
    [CreateDate]  DATETIME      CONSTRAINT [DF_App_Sys_AutoNumber_CreateDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_App_Sys_AutoNumber] PRIMARY KEY CLUSTERED ([ObjName] ASC)
);


  protected void btnSave_Click(object sender, EventArgs e)
  {
      HalfYearly_Records.UnbindData();

      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["VCode"] = Session["Username"].ToString();
      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Year"] = Year.SelectedValue;
      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Period"] = SearchPeriod.SelectedValue;
     

      string vc = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["VCode"].ToString();
      string year = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Year"].ToString();
      string Period = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Period"].ToString();



      BL_Half_Yearly blobj = new BL_Half_Yearly();
      DataSet dsExist = blobj.chkExist(vc, year, Period);
      bool isExist = dsExist != null && dsExist.Tables[0].Rows.Count > 0;

      if (isExist)
      {
          //blobj.GetDelete(vc, year, Period);
          //string oldRef = dsExist.Tables[0].Rows[0]["RefNo"].ToString();
          //PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["RefNo"] = oldRef;
          //PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ResubmitedOn"] = System.DateTime.Now;
          //PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].AcceptChanges();

          DataSet ds = new DataSet();
          ds = blobj.GetDelete(vc, year, Period);

          if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].RowState.ToString() == "Modified")
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
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Error While Saving !");
      }
  }
