  protected void Attachment_Dept_Click(object sender, BulletedListEventArgs e)
  {
      string filePath = e.Index >= 0 ? ((BulletedList)sender).Items[e.Index].Value : "";
      if (!string.IsNullOrEmpty(filePath))
      {
          Response.ContentType = ContentType;
          Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
          Response.TransmitFile(@"D:/Cybersoft_Doc/CLMS/Attachments/" + filePath);
          Response.End();
      }
      else
      {
          ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('There is no file to Download');", true);
      }
  }




  protected void Vendor_Block_Unblock_RFQ_recordsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
  {
      if (e.Row.RowType == DataControlRowType.DataRow)
      {
          var bulletedList = e.Row.FindControl("Attachment_Dept_List") as BulletedList;
          string attachments = DataBinder.Eval(e.Row.DataItem, "Attachment_Dept")?.ToString();
          if (!string.IsNullOrEmpty(attachments))
          {
              foreach (string file in attachments.Split(',')) 
              {
                  bulletedList.Items.Add(new ListItem(System.IO.Path.GetFileName(file), file));
              }
          }
      }
  }
