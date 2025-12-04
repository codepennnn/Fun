      <asp:GridView ID="gvRefUpload" runat="server" AutoGenerateColumns="False"
          CssClass="table table-bordered table-striped compact-grid" >
         
          <HeaderStyle BackColor="#2f4f4f" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" />
          
          <Columns>


              
              <asp:BoundField DataField="RefNo" HeaderText="Reference No" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" />

              <asp:TemplateField HeaderText="Upload Attachment">
                  <ItemTemplate>
                      <asp:FileUpload ID="Final_Attachment" runat="server" AllowMultiple="true" CssClass="form-control" />
                  </ItemTemplate>
              </asp:TemplateField>

          </Columns>
      </asp:GridView>

      <div class="text-center mt-3">
          <asp:Button ID="btnSave" runat="server" CssClass="btn btn-warning" OnClick="btnSave_Click"
              Text="Upload All Attachments" />
      </div>



        protected void btnSave_Click(object sender, EventArgs e)
  {


      string refno = 
      string vcode = Session["UserName"].ToString();


      BL_Half_Yearly blobj = new BL_Half_Yearly();
      DataSet ds = blobj.Get_Data_By_RefNo(refno, vcode);

      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
      PageRecordDataSet.Merge(ds);




      string getFileName = "";
      List<string> FileList = new List<string>();

      FileUpload fu = (FileUpload)gvRefUpload.Rows[0].FindControl("Final_Attachment");

      if (fu.HasFile)
      {
          foreach (HttpPostedFile htfiles in fu.PostedFiles)
          {
              getFileName = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ID"].ToString()
                            + "_" + Path.GetFileName(htfiles.FileName);

              getFileName = Regex.Replace(getFileName,
                  @"[,+*/?|><&=\#%:;@^$?:'()!~}{`]", "");

              htfiles.SaveAs(@"C:/Cybersoft_Doc/CLMS/Attachments/" + getFileName);

              FileList.Add(getFileName);
          }

          string attachments = string.Join(",", FileList);


          foreach (DataRow r in PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows)
          {
              r["Final_Attachment"] = attachments;
              r["Status"] = "Pending With CC";
          }
      }

      bool result = Save();

      if (result)
      {

          btn.Visible = false;

          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
      }
      else
      {
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
      }
  }
