using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bonus : System.Web.UI.Page
{
    protected void btnDwnld_Click(object sender, EventArgs e)
    {
        // ✅ Make sure paging is off so all visible rows are exported
        Grid.AllowPaging = false;

        // ❌ DO NOT rebind here if you want to keep user edits
        // Grid.DataBind();

        // Prepare HTTP headers
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Bonus_Compliance_Details.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";

        // Capture GridView HTML
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            // Replace input controls (TextBox etc.) with their current values
            PrepareGridViewForExport(Grid);

            Grid.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    // 🔑 This override prevents the “must be inside a form” error
    public override void VerifyRenderingInServerForm(Control control)
    {
        // required but intentionally empty
    }

    // Recursively convert TextBoxes (and other editable controls) to plain text
    private void PrepareGridViewForExport(Control parent)
    {
        for (int i = 0; i < parent.Controls.Count; i++)
        {
            Control c = parent.Controls[i];

            if (c is TextBox tb)
            {
                parent.Controls.Remove(c);
                parent.Controls.AddAt(i, new Literal { Text = HttpUtility.HtmlEncode(tb.Text) });
            }
            else if (c.HasControls())
            {
                PrepareGridViewForExport(c);
            }
        }
    }
}
