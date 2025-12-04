<div class="form-group col-md-4">
    <label for="lblRefNo" class="m-0 mr-0 p-0 col-form-label-sm col-sm-2 font-weight-bold fs-6">Ref No:</label>
    <asp:DropDownList ID="ddlRefNo" runat="server" 
        CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"
        OnSelectedIndexChanged="ddlRefNo_SelectedIndexChanged">
        <asp:ListItem Value="">-- Select RefNo --</asp:ListItem>
    </asp:DropDownList>
</div>


protected void Search_Click(object sender, EventArgs e)
{
    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet dsRef = blobj.GetRefNoList(vcode, period, year);

    ddlRefNo.Items.Clear();
    ddlRefNo.Items.Add(new ListItem("-- Select RefNo --", ""));

    if (dsRef != null && dsRef.Tables[0].Rows.Count > 0)
    {
        ddlRefNo.DataSource = dsRef;
        ddlRefNo.DataTextField = "RefNo";
        ddlRefNo.DataValueField = "RefNo";
        ddlRefNo.DataBind();
    }
    else
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No RefNo found for the selected period.");
    }
}
