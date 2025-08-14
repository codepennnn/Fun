
                       <asp:TemplateField HeaderText="For Department Purpose" SortExpression="Attachment_Dept" >
                                            <ItemTemplate>
                                                <asp:BulletedList runat="server" ID="Attachment_Dept" CssClass="attachment-list" DisplayMode="HyperLink" OnClick="Attachment_Dept_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField> 

     protected void Attachment_Dept_Click(object sender, BulletedListEventArgs e)
     {
         string filePath = (sender as LinkButton).CommandArgument;
         if (filePath != "")
         {
             Response.ContentType = ContentType;
             Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
             Response.TransmitFile(@"D:/Cybersoft_Doc/CLMS/Attachments/" + filePath);
             Response.End();
         }
         else
             System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('There is no file to Download');", true);
     }
