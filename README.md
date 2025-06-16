<div style="border:1px solid #ccc;">
    <asp:GridView ID="FNF_Summary_Grid" runat="server" 
        CellPadding="4" 
        Width="100%" 
        ForeColor="#333333" 
        ShowHeaderWhenEmpty="True" 
        HeaderStyle-Font-Size="Smaller" 
        RowStyle-Font-Size="Smaller" 
        AutoGenerateColumns="false"
        DataKeyNames="ID"
        OnSelectedIndexChanging="FNF_Summary_Grid_SelectedIndexChanging" 
        OnSelectedIndexChanged="FNF_Summary_Grid_SelectedIndexChanged">
    </asp:GridView>
</div>
