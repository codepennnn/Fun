    ((RadioButtonList)EmployeeMasterFormID_Record.Rows[0].FindControl("ApprvStatus")).SelectedValue = ds1.Tables[0].Rows[0]["ApprvStatus"].ToString();

       <asp:DropDownList  ID="ApprvStatus" runat="server" CssClass="form-control form-control-sm col-sm-8" >
                      <asp:ListItem Text="" Value="" />
                      <asp:ListItem Text="Approve"    Value="Approve" />
                      <asp:ListItem Text="Return"     Value="Return" />
                      <asp:ListItem Text="GP Return"  Value="GP Return" />
                      <asp:ListItem Text="Pending"    Value="Pending" />
                       <asp:ListItem Text="Drafted"    Value="Drafted" />

                     <%-- <asp:ListItem Text="GP Pending" Value="GP Pending" />--%>
                      
                  </asp:DropDownList>

                  error - System.ArgumentOutOfRangeException: ''ApprvStatus' has a SelectedValue which is invalid because it does not exist in the list of items.
