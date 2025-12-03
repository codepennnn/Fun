if (result)
{
    // 1️⃣ Clear local dataset
    PageRecordDataSet.Clear();

    // 2️⃣ Reset FormContainer fully
    Upload_Half_Yearly_Record.NewRecord();   // Reset internal row
    Upload_Half_Yearly_Record.Visible = false;
    Upload_Half_Yearly_Record.BindData();

    // 3️⃣ Reset dropdown
    SearchLL.ClearSelection();
    SearchLL.Items.Clear();
    SearchLL.Items.Add(new ListItem("-- Select Ref No --", ""));

    // 4️⃣ Hide search area
    divLL.Style["display"] = "none";
    SearchLLBtn.Visible = false;

    MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success,
                  "Record saved successfully !");
}
