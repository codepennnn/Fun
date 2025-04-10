<fieldset class="mt-5 shadow-sm" style="border: 1px solid #bfbebe; padding: 15px 25px; border-radius: 6px;">
    <legend style="width: auto; font-size: 16px; color: #0000FF"><b>Previously made entries</b></legend>

    <asp:GridView ID="gvFNFStartPageRecords" runat="server" CssClass="table table-bordered table-hover animate__animated animate__fadeIn"
        AutoGenerateColumns="False" GridLines="None" Width="100%" 
        DataKeyNames="V_Code" DataSource="<%# PageRecordsDataSet %>" ShowHeaderWhenEmpty="True">
        
        <HeaderStyle CssClass="table-dark text-center" />
        <RowStyle CssClass="text-center" />
        <AlternatingRowStyle CssClass="table-light" />
        <PagerStyle CssClass="bg-primary text-white text-center fw-bold" HorizontalAlign="Center" />
        
        <Columns>
            <asp:BoundField DataField="V_Code" HeaderText="Vendor Code" />
            <asp:BoundField DataField="V_NAME" HeaderText="Vendor Name" />
            <asp:BoundField DataField="WO_NO" HeaderText="Workorder No." />
            <asp:BoundField DataField="L1_CreatedBy" HeaderText="L1 CreatedBy" />
            <asp:BoundField DataField="L1_CreatedOn" HeaderText="L1 CreatedOn" />
            <asp:BoundField DataField="L2_CreatedOn" HeaderText="L2 CreatedOn" />
            <asp:BoundField DataField="L2_CreatedBy" HeaderText="L2 CreatedBy" />
            <asp:BoundField DataField="RefNo" HeaderText="Reference No." />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
        </Columns>
    </asp:GridView>
</fieldset>
