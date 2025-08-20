<div class="form-inline row">
    <!-- Search By -->
    <div class="form-group col-md-4 mb-1">
        <label for="ddlSearch" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Search With:</label>
        <asp:DropDownList ID="ddlSearch" runat="server" CssClass="form-control form-control-sm col-sm-5">
            <asp:ListItem Value="">--Select--</asp:ListItem>
            <asp:ListItem Value="WorkOrderNo">WorkOrder No</asp:ListItem>
            <asp:ListItem Value="LicNo">Lic No</asp:ListItem>
        </asp:DropDownList>
    </div>

    <!-- Search Text -->
    <div class="form-group col-md-4 mb-1">
        <label for="txtSearch" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Enter detail:</label>
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
    </div>

    <!-- Search Button -->
    <div class="form-group col-md-3 mb-1">
        <asp:Button ID="btnSearch" runat="server" Text="Search"
            OnClick="btnSearch_Click"
            CssClass="btn btn-sm btn-info" ValidationGroup="search" />
    </div>
</div>


<!-- GridView -->
<!-- GridView -->
<div class="w-100 border" style="overflow: auto; height:350px;">
    <asp:GridView ID="C3_Records_Grid" runat="server" 
        AutoGenerateColumns="True" 
        AllowPaging="true" PageSize="10" 
        AllowSorting="true"
        CellPadding="4" GridLines="None" Width="100%"
        OnPageIndexChanging="C3_Records_Grid_PageIndexChanging">

        <AlternatingRowStyle BackColor="#cccccc" ForeColor="#284775" />
        <EditRowStyle BackColor="#ffffff" />
        <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerSettings Mode="Numeric" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</div>


protected void C3_Records_Grid_PageIndexChanging(object sender, GridViewPageEventArgs e)
{
    C3_Records_Grid.PageIndex = e.NewPageIndex;

    // Re-run the search when changing page
    btnSearch_Click(sender, e);
}
