<asp:GridView ID="Remarks_grid" runat="server" AutoGenerateColumns="false"
    CssClass="table table-bordered table-striped table-sm"
    HeaderStyle-CssClass="thead-dark"
    RowStyle-CssClass="align-middle"
    OnRowDataBound="Remarks_grid_RowDataBound">

    <Columns>

        <!-- Hidden ID Column -->
        <asp:TemplateField Visible="False">
            <ItemTemplate>
                <asp:Label ID="ID" runat="server"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <!-- Remarks Column -->
        <asp:BoundField DataField="Remarks" HeaderText="Remarks">
            <ItemStyle Width="50%" HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>

        <!-- Attachment Column -->
        <asp:BoundField DataField="Attachment" HeaderText="Attachment">
            <ItemStyle Width="50%" HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>

    </Columns>
</asp:GridView>
