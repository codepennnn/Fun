   <cc1:DetailsContainer ID="WorkOrder_Exemption_Records" runat="server" AutoGenerateColumns="False"
       AllowPaging="true" CellPadding="4" GridLines="None" Width="100%" DataMember="App_WorkOrder_Exemption"
       DataKeyNames="ID" DataSource="<%# PageRecordsDataSet %>"
       ForeColor="#333333" ShowHeaderWhenEmpty="True" OnPageIndexChanging="WorkOrder_Exemption_Records_PageIndexChanging"
       OnSelectedIndexChanged="WorkOrder_Exemption_Records_SelectedIndexChanged" PageSize="10" PagerSettings-Visible="True" PagerStyle-HorizontalAlign="Center"
       PagerStyle-Wrap="False" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller" OnPreRender="WorkOrder_Exemption_Records_PreRender">
       <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
       <Columns>
           <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="False">
               <ItemTemplate>
                   <asp:Label ID="ID" runat="server"></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>

           <asp:TemplateField HeaderText="Sl No." SortExpression="Sl_No"
               HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
               <ItemTemplate><%# Container.DataItemIndex + 1 + "."%> </ItemTemplate>
           </asp:TemplateField>


           <asp:TemplateField HeaderText="Created On" SortExpression="CreatedOn">
               <ItemTemplate>
                   <asp:Label ID="CreatedOn" runat="server"></asp:Label>&nbsp
               </ItemTemplate>
           </asp:TemplateField>



           <asp:TemplateField HeaderText="Vendor Code" SortExpression="VendorCode">
               <ItemTemplate>
                   <asp:Label ID="VendorCode" runat="server"></asp:Label>&nbsp
               </ItemTemplate>
           </asp:TemplateField>


           <asp:TemplateField HeaderText="Vendor Name" SortExpression="VendorName">
               <ItemTemplate>
                   <asp:Label ID="VendorName" runat="server"></asp:Label>&nbsp
               </ItemTemplate>
           </asp:TemplateField>



             <asp:TemplateField HeaderText="WorkOrder No." 
                  SortExpression="WorkOrderNo">
                  <ItemTemplate>
                  <B> <asp:LinkButton ID="LinkButton1"  runat="server"  CommandName="select" ForeColor="#003399" Text='<%# Bind("WorkOrderNo") %>' ></asp:LinkButton> </B>
                  </ItemTemplate>
                  <HeaderStyle HorizontalAlign="Left" />
              </asp:TemplateField>

           <asp:TemplateField HeaderText="Status" SortExpression="Status">
               <ItemTemplate>
                   <asp:Label ID="Status" runat="server"></asp:Label>&nbsp
               </ItemTemplate>
           </asp:TemplateField>



             <asp:TemplateField HeaderText="Return Attachment" SortExpression="ReturnAttachment" >
                               <ItemTemplate>
                                   <asp:BulletedList runat="server" ID="ReturnAttachment" CssClass="attachment-list" DisplayMode="HyperLink" OnClick="ReturnAttachment_Click" />
                               </ItemTemplate>
                           </asp:TemplateField> 





       </Columns>
       <EditRowStyle BackColor="#999999" />
       <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
       <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
       <PagerSettings Mode="Numeric" />
       <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
       <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
       <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
       <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
       <SortedAscendingCellStyle BackColor="#E9E7E2" />
       <SortedAscendingHeaderStyle BackColor="#506C8C" />
       <SortedDescendingCellStyle BackColor="#FFFDF8" />
       <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
   </cc1:DetailsContainer>
