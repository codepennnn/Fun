<asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <!-- Your GridView and other stuff here -->
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>
