<asp:GridView ID="gvRefUpload" runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped styled-grid"
    Width="100%"
    PagerSettings-Visible="False"
    PagerStyle-HorizontalAlign="Center"
    PagerStyle-Wrap="False"
    RowStyle-ForeColor="Black"
    HeaderStyle-Font-Size="13px"
    RowStyle-Font-Size="11px"
    Style="margin-top: 12px;">

    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

    <Columns>
        <asp:BoundField DataField="RefNo" HeaderText="Reference No" />

        <asp:TemplateField HeaderText="Upload Attachment">
            <ItemTemplate>
                <asp:FileUpload ID="fuUpload" runat="server" AllowMultiple="true"
                    CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>

    <HeaderStyle BackColor="#003570" ForeColor="White"
        Font-Bold="True" HorizontalAlign="Center" />

    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />

    <FooterStyle BackColor="#003570" ForeColor="White" Font-Bold="True" />

    <EditRowStyle BackColor="#999999" />

    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />

    <SortedAscendingCellStyle BackColor="#E9E7E2" />
    <SortedAscendingHeaderStyle BackColor="#506C8C" />
    <SortedDescendingCellStyle BackColor="#FFFDF8" />
    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

</asp:GridView>
