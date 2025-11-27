BL_Half_Yearly blobj = new BL_Half_Yearly();
DataSet dsExist = blobj.chkExist(vc, year, Period);
bool isExist = dsExist != null && dsExist.Tables[0].Rows.Count > 0;

// Always delete existing record from DB
blobj.GetDelete(vc, year, Period);

// Remove existing rows from PageRecordDataSet
PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Clear();

// Add NEW row
PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Add(
    PageRecordDataSet.Tables["App_Half_Yearly_Details"].NewRow()
);

// Work directly on PageRecordDataSet (your requirement)
var tbl = PageRecordDataSet.Tables["App_Half_Yearly_Details"];

// If data existed → reuse RefNo, set Resubmitted date
if (isExist)
{
    tbl.Rows[0]["RefNo"] = dsExist.Tables[0].Rows[0]["RefNo"].ToString();
    tbl.Rows[0]["ResubmitedOn"] = DateTime.Now;
}

// Common fields (both insert and resubmit)
tbl.Rows[0]["VCode"] = Session["Username"].ToString();
tbl.Rows[0]["Year"] = Year.SelectedValue;
tbl.Rows[0]["Period"] = SearchPeriod.SelectedValue;
tbl.Rows[0]["CreatedBy"] = Session["UserName"].ToString();
tbl.Rows[0]["CreatedOn"] = DateTime.Now;

// IMPORTANT: Do NOT call AcceptChanges() here
// RowState = Added → Save() will INSERT correctly

bool result = Save();

if (result)
{
    // Now AcceptChanges is allowed
    PageRecordDataSet.AcceptChanges();

    string Ref_No = blobj.Get_Ref_No(tbl.Rows[0]["ID"].ToString());

    ScriptManager.RegisterClientScriptBlock(
        this,
        this.GetType(),
        "AlertBox",
        "alert('Your Half Yearly Ref No. is: " + Ref_No + "');",
        true
    );

    PageRecordDataSet.Clear();
    HalfYearly_Records.BindData();
    btnSave.Visible = false;

    MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
}
else
{
    MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
}
