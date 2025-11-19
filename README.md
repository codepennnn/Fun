    <asp:GridView ID="Remarks_grid" runat="server" AutoGenerateColumns="false"
        AllowPaging="false" CellPadding="0" GridLines="Both" Width="100%"
        ForeColor="#333333" ShowHeaderWhenEmpty="False" OnRowDataBound="Remarks_grid_RowDataBound"
        PageSize="10" PagerSettings-Visible="false" PagerStyle-HorizontalAlign="Center"
        PagerStyle-Wrap="True" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Small" CssClass="m-auto border border-info"
        HeaderStyle-HorizontalAlign="Center" RowStyle-ForeColor="Black" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField Visible="False">
                <ItemTemplate>
                    <asp:Label ID="ID" runat="server"></asp:Label>

                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-Width="30" />
            <asp:BoundField DataField="Attachment" HeaderText="Attachment" ItemStyle-Width="30" />

        </Columns>
           <EditRowStyle BackColor="#ffffff" />
         <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
         <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
         <PagerSettings Mode="Numeric" />
         <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True"  CssClass="pager1" />
         <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
         <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
         <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
         <SortedAscendingCellStyle BackColor="#E9E7E2" />
         <SortedAscendingHeaderStyle BackColor="#506C8C" />
         <SortedDescendingCellStyle BackColor="#FFFDF8" />
         <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>

    make this tabluar format style
