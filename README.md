protected void SearchLLBtn_Click(object sender, EventArgs e)
{
    // 1️⃣ If no ref no selected → STOP + hide file upload section
    if (string.IsNullOrEmpty(SearchLL.SelectedValue))
    {
        PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
        Upload_Half_Yearly_Record.Visible = false;   // HIDE upload container

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                      "Please select a Ref No first.");
        return;
    }

    // 2️⃣ If RefNo selected → load the data
    PageRecordDataSet.EnforceConstraints = false;

    string refno = SearchLL.SelectedValue;
    string vcode = Session["UserName"].ToString();

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.Get_Data_By_RefNo(refno, vcode);

    // 3️⃣ Load into PageRecordDataSet
    PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
    PageRecordDataSet.Merge(ds);

    // 4️⃣ Show file upload section with data
    Upload_Half_Yearly_Record.Visible = true;
    Upload_Half_Yearly_Record.BindData();

    // 5️⃣ Show dropdown too
    divLL.Style["display"] = "flex";
}
