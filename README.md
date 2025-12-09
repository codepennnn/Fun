GO
CREATE TRIGGER [dbo].[RefNo_Half_Yearly] 
   ON  dbo.App_Half_Yearly_Details
   INSTEAD OF INsert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT * INTO #Inserted FROM Inserted
 
declare		@OutPut varchar(255)

EXEC	[dbo].[GetAutoNumberNoLeadingZero]
		@p1=N'HALFYEARLY',
		@OutPut = @OutPut OUTPUT

     UPDATE #Inserted SET RefNo = @OutPut
     INSERT INTO App_Half_Yearly_Details SELECT * FROM #Inserted
    -- Insert statements for trigger here

END

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

              string oldRef = dsExist.Tables[0].Rows[0]["RefNo"].ToString();
              for (int i = 0; i < PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Count; i++)
              {
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["VCode"] = Session["Username"].ToString();
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Year"] = Year.SelectedValue;
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Period"] = SearchPeriod.SelectedValue;
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["RefNo"] = oldRef;
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
          DataSet ds1 = new DataSet();
          ds = blobj.GetDelete(vc, year, Period);

      
          string refNo = blobj.Generate_Global_RefNo("HALFYEARLY");

          if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].RowState == DataRowState.Modified)
          {

              for (int i = 0; i < PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Count; i++)
              {
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["VCode"] = Session["Username"].ToString();
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Year"] = Year.SelectedValue;
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Period"] = SearchPeriod.SelectedValue;
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["RefNo"] = refNo;
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].AcceptChanges();
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].SetAdded();
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedBy"] = Session["UserName"].ToString();
                  PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedOn"] = System.DateTime.Now;

              }


          }


                  public DataSet Generate_Global_RefNo(string objName)
        {
            string strSQL = @"select * from App_Sys_AutoNumber where ObjName=@objName";

            Dictionary<string, object> objParam = new Dictionary<string, object>();

            objParam.Add("objName", objName);
            DataHelper dh = new DataHelper();
            DataSet ds = dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
            return ds;
        }
