 function validateCompliance() {

  
     var fileInput = document.getElementById("MainContent_Upload_Half_Yearly_Record_Final_Attachment_0");


     var checks = document.querySelectorAll(".compact-grid input[type='file']");
     var atLeastOne = Array.from(checks).some(cb => cb.checked);

     if (!atLeastOne) {
         alert("Please upload All the attachment.");
         return false;
     }



     

 }


   <asp:GridView ID="gvRefUpload" runat="server" AutoGenerateColumns="False"
      CssClass="table table-bordered table-striped compact-grid" >
     
      <HeaderStyle BackColor="#2f4f4f" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" />
      
      <Columns>


          
          <asp:BoundField DataField="LabourLicNo" HeaderText="LabourLicNo" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" />

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


all attachment should be filled then submit and attachment only pdf and excel


and add validation below that if already uploaded data on selected month year then show alert message 
     protected void Search_Click(object sender, EventArgs e)
     {
         string vcode = Session["UserName"].ToString();
         int year = Convert.ToInt32(Year.SelectedValue);
         string period = SearchPeriod.SelectedValue;

         BL_Half_Yearly blobj = new BL_Half_Yearly();
         DataSet ds = blobj.Get_LabourLicNo(vcode, period, year);

         if (ds == null || ds.Tables[0].Rows.Count == 0)
         {
             MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                 "No records found. Please submit Half Yearly first.");
             gvRefUpload.Visible = false;
             return;
         }

         gvRefUpload.Visible = true;
         gvRefUpload.DataSource = ds.Tables[0];
         gvRefUpload.DataBind();
         btnSave.Visible = true;
     }




  
