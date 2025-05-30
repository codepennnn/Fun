  if (PF_ESI_Record.Rows.Count > 0)
  {
      ((BulletedList)PF_ESI_Record.Rows[0].FindControl("PF_ESIAttach1")).Items.Clear();
      string[] strattachments;
      try
      {
          if (!string.IsNullOrEmpty(PageRecordDataSet.Tables["App_PF_ESI_Summary"].Rows[0]["PF_ESIAttach"].ToString()))
          {
              strattachments = PageRecordDataSet.Tables["App_PF_ESI_Summary"].Rows[0]["PF_ESIAttach"].ToString().Split(',');
              foreach (string image in strattachments)
              {
                  ListItem link = new ListItem();
                  link.Value = "~/Attachments/" + image;
                  link.Text = image.Substring(37);
                  link.Attributes.CssStyle.Add("text-decoration", "underline");
                  link.Attributes.CssStyle.Add("color", "blue");
                  ((BulletedList)PF_ESI_Record.Rows[0].FindControl("PF_ESIAttach1")).Items.Add(link);
              }
          }
      }
      catch { }
  }
