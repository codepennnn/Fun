      <asp:GridView ID="gvRefUpload" runat="server" AutoGenerateColumns="False"
          CssClass="table table-bordered table-striped" Width="100%" >
         
          <HeaderStyle BackColor="#2f4f4f" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" />
          
          <Columns>


              
              <asp:BoundField DataField="RefNo" HeaderText="Reference No" />

              <asp:TemplateField HeaderText="Upload Attachment">
                  <ItemTemplate>
                      <asp:FileUpload ID="fuUpload" runat="server" AllowMultiple="true" CssClass="form-control" />
                  </ItemTemplate>
              </asp:TemplateField>

          </Columns>
      </asp:GridView>
