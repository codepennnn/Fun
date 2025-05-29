<div style="height:400px; overflow-y:auto; border:1px solid #ccc;">
    <cc1:DetailsContainer ID="LeaveReportRecords" runat="server" AutoGenerateColumns="False" 
        AllowPaging="False" CellPadding="4" GridLines="None" Width="100%" 
        DataMember="App_Leave_Comp_Details" DataKeyNames="WorkOrderNo" 
        DataSource="<%# PageRecordsDataSet %>" ForeColor="#333333" 
        ShowHeaderWhenEmpty="True" OnSelectedIndexChanged="LeaveReportRecords_SelectedIndexChanged" 
        HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller" class="w-100 border">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </cc1:DetailsContainer>
</div>
