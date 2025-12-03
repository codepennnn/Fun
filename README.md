   if (result)
   {
       PageRecordDataSet.Clear();
       Upload_Half_Yearly_Record.BindData();
       Upload_Half_Yearly_Record.Visible = false;
       SearchLLBtn.Visible = false;
       MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
   }
