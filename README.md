protected void btnDwnld_Click(object sender, EventArgs e)
{
    // Turn off paging so every currently visible row is included
    Grid.AllowPaging = false;

    // Re-bind ONLY if you need to refresh data before export.
    // If you truly want the live, on-screen edits, DO NOT rebind.
    // Grid.DataBind();

    Response.Clear();
    Response.Buffer = true;
    Response.AddHeader("content-disposition", "attachment;filename=Bonus_Compliance_Details.xls");
    Response.Charset = "";
    Response.ContentType = "application/vnd.ms-excel";

    // Make sure controls can render
    System.IO.StringWriter sw = new System.IO.StringWriter();
    HtmlTextWriter hw = new HtmlTextWriter(sw);

    // Remove controls like TextBox and render their current text values
    PrepareGridViewForExport(Grid);

    Grid.RenderControl(hw);
    Response.Output.Write(sw.ToString());
    Response.Flush();
    Response.End();
}

// Needed to allow rendering outside of a form
public override void VerifyRenderingInServerForm(Control control)
{
    // Required override – leave empty
}

// Replace input controls with literal text so their current values are exported
private void PrepareGridViewForExport(Control ctrl)
{
    for (int i = 0; i < ctrl.Controls.Count; i++)
    {
        Control current = ctrl.Controls[i];
        if (current is TextBox)
        {
            // Grab the live user-entered value
            Literal lit = new Literal { Text = ((TextBox)current).Text };
            ctrl.Controls.Remove(current);
            ctrl.Controls.AddAt(i, lit);
        }
        else if (current.HasControls())
        {
            PrepareGridViewForExport(current);
        }
    }
}
