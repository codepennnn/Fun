protected void Attachment_Dept_Click(object sender, BulletedListEventArgs e)
{
    string filePath = e.Index >= 0 ? ((BulletedList)sender).Items[e.Index].Value : "";
    if (!string.IsNullOrEmpty(filePath))
    {
        Response.ContentType = "application/pdf";
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
        Response.TransmitFile(@"D:/Cybersoft_Doc/CLMS/Attachments/" + filePath);
        Response.End();
    }
    else
    {
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('There is no file to Download');", true);
    }
}
