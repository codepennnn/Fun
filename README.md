   if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"] == "Return")
   {

      
       string getFileName = "";
       List<string> FileList = new List<string>();
       if (((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("ReturnAttachment")).HasFile)
       {
           foreach (HttpPostedFile htfiles in ((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("ReturnAttachment")).PostedFiles)
           {
               getFileName = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
               getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
               htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
               FileList.Add(getFileName);
           }
           PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ReturnAttachment"] = string.Join(",", FileList);
       }

   }

        <div id="div_ReturnAttachment" class="form-inline row mt-2" runat="server" visible="false"> 
          <div class="form-group col-md-6 mb-2">
      <label for="Return_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start" >Return Attachment:</label>
          <asp:FileUpload ID="ReturnAttachment" runat="server" AllowMultiple="true" Font-Size="Small"/>
          <asp:BulletedList ID="BulletedList1" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank"/>
                           
 
          </div>
    </div>
