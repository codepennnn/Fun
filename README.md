ddlRefNo.DataSource = dsRef;
ddlRefNo.DataTextField = "RefNo";
ddlRefNo.DataValueField = "RefNo";
ddlRefNo.DataBind();

ddlRefNo.Items.Insert(0, new ListItem("-- Select Ref No --", ""));
