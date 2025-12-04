<asp:GridView ID="gvRefUpload" runat="server" AutoGenerateColumns="False" CssClass="table">
    <Columns>
        <asp:BoundField DataField="RefNo" HeaderText="Reference No" />

        <asp:TemplateField HeaderText="Upload">
            <ItemTemplate>
                <asp:FileUpload ID="fuUpload" runat="server" AllowMultiple="true" />
                <asp:Button ID="btnUpload" runat="server" Text="Upload"
                            CommandName="Upload"
                            CommandArgument='<%# Eval("RefNo") %>'
                            CssClass="btn btn-sm btn-primary" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Existing Files">
            <ItemTemplate>
                <asp:Literal ID="litFiles" runat="server"
                    Text='<%# Eval("Final_Attachment") %>'></asp:Literal>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>


protected void Search_Click(object sender, EventArgs e)
{
    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.Get_Ref_NoDDL(vcode, period, year);

    if (ds == null || ds.Tables[0].Rows.Count == 0)
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No records found. Please submit Half Yearly first.");
        gvRefUpload.Visible = false;
        return;
    }

    gvRefUpload.Visible = true;
    gvRefUpload.DataSource = ds.Tables[0];
    gvRefUpload.DataBind();
}


protected void gvRefUpload_RowCommand(object sender, GridViewCommandEventArgs e)
{
    if (e.CommandName == "Upload")
    {
        string refNo = e.CommandArgument.ToString();
        GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;

        FileUpload fu = (FileUpload)row.FindControl("fuUpload");

        if (!fu.HasFile)
        {
            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                "Please select a file to upload.");
            return;
        }

        List<string> fileNames = new List<string>();

        foreach (HttpPostedFile file in fu.PostedFiles)
        {
            string fileName = refNo.Replace("/", "_") + "_" + file.FileName;
            file.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + fileName);
            fileNames.Add(fileName);
        }

        string finalAttachments = string.Join(",", fileNames);

        BL_Half_Yearly blobj = new BL_Half_Yearly();
        blobj.SaveAttachment(refNo, finalAttachments);

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success,
            "Attachment uploaded successfully!");
    }
}

