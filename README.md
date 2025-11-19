  protected void WorkOrder_Exemption_Record_RowDataBound(object sender, GridViewRowEventArgs e)
  {
      if (WorkOrder_Exemption_Record.Rows.Count > 0)
      {



          TextBox txtWO = (TextBox)e.Row.FindControl("WorkOrderNo");


          CheckBoxList chkWO = (CheckBoxList)Action_Record.FindControl("cc_wo");

          if (chkWO != null)
              chkWO.Items.Clear();

          if (txtWO != null && !string.IsNullOrWhiteSpace(txtWO.Text))
          {
              string[] workorders = txtWO.Text.Split(new char[] { ',', '|' },
                                                     StringSplitOptions.RemoveEmptyEntries);

              foreach (string wo in workorders)
              {
                  chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
              }

              foreach (ListItem item in chkWO.Items)
                  item.Selected = true;
          }


          ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Items.Clear();
          string[] attachments;
          if (!string.IsNullOrEmpty(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Attachment"].ToString()))
          {
              attachments = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Attachment"].ToString().Split(',');

              foreach (string image in attachments)
              {
                  ListItem link = new ListItem();
                  //link.Value = "~/Attachments/" + image;
                  link.Value = "~/FileDownloadHandler.ashx?file=" + Server.UrlEncode(image);
                  link.Text = image;
                  link.Attributes.CssStyle.Add("text-decoration", "underline");
                  link.Attributes.CssStyle.Add("color", "blue");
                  link.Text = image.Substring(37);
                  ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Items.Add(link);
              }


           

          }






      }
  }
