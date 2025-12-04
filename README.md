              <asp:GridView ID="gvRefUpload" runat="server" AutoGenerateColumns="False"
                  CssClass="table table-bordered table-striped" Width="100%" PagerSettings-Visible="False" PagerStyle-HorizontalAlign="Center" RowStyle-ForeColor="Black"
                      PagerStyle-Wrap="False" HeaderStyle-Font-Size="13px" RowStyle-Font-Size="11px" class="border " Style="margin-top: 12px;" CssClass="styled-grid">
                      <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                 
                <%--  <HeaderStyle BackColor="#2f4f4f" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" />--%>
                  
                  <Columns>


                      
                      <asp:BoundField DataField="RefNo" HeaderText="Reference No" />

                      <asp:TemplateField HeaderText="Upload Attachment">
                          <ItemTemplate>
                              <asp:FileUpload ID="fuUpload" runat="server" AllowMultiple="true" CssClass="form-control" />
                          </ItemTemplate>
                      </asp:TemplateField>

                  </Columns>
                    <EditRowStyle BackColor="#999999" />
<FooterStyle BackColor="#003570" ForeColor="White" Font-Bold="True" />
<HeaderStyle BackColor="#003570" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
<SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
<SortedAscendingCellStyle BackColor="#E9E7E2" />
<SortedAscendingHeaderStyle BackColor="#506C8C" />
<SortedDescendingCellStyle BackColor="#FFFDF8" />
<SortedDescendingHeaderStyle BackColor="#6F8DAE" />
              </asp:GridView>
