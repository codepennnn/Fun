protected void Vendor_Block_Unblock_RFQ_record_RowDataBound(object sender, GridViewRowEventArgs e)
{
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
        var bulletedList = e.Row.FindControl("Attachment_Dept_List") as BulletedList;
        string attachments = DataBinder.Eval(e.Row.DataItem, "Attachment_Dept")?.ToString();
        if (!string.IsNullOrEmpty(attachments))
        {
            foreach (string file in attachments.Split(',')) // assuming comma separated
            {
                bulletedList.Items.Add(new ListItem(System.IO.Path.GetFileName(file), file));
            }
        }
    }
}
