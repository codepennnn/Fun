                      <asp:GridView ID="Remarks_grid" runat="server" AutoGenerateColumns="false"
                          AllowPaging="false" CellPadding="0" GridLines="Both" Width="100%" 
                                    ForeColor="#333333" ShowHeaderWhenEmpty="False" OnRowDataBound="Remarks_grid_RowDataBound"
                                    PageSize="10" PagerSettings-Visible="false" PagerStyle-HorizontalAlign="Center" 
                                    PagerStyle-Wrap="True" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Small" CssClass="m-auto border border-info" 
                                    HeaderStyle-HorizontalAlign="Center"  RowStyle-ForeColor="Black" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"> 
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                              <Columns> 
                                    <asp:TemplateField  Visible="False">
                                            <ItemTemplate >
                                                <asp:Label ID="ID" runat="server"></asp:Label>
                                                
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-Width="30" />    
                     
                              </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                    <HeaderStyle BackColor="#328cda" Font-Bold="True" ForeColor="White" />
                                    <PagerSettings Mode="Numeric" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True"  CssClass="pager1" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                       </asp:GridView>
   protected void btnSave_Click(object sender, EventArgs e)
   {


       if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
       {

          
           string getFileName = "";
           List<string> FileList = new List<string>();
           if (((FileUpload)Remarks_grid.Rows[0].FindControl("ReturnAttachment")).HasFile)
           {
               foreach (HttpPostedFile htfiles in ((FileUpload)Remarks_grid.Rows[0].FindControl("ReturnAttachment")).PostedFiles)
               {
                   getFileName = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
                   getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                   htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
                   FileList.Add(getFileName);
               }
               PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ReturnAttachment"] = string.Join(",", FileList);
           }

       }





       WorkOrder_Exemption_Record.UnbindData();
       Action_Record.UnbindData();

       string Remarks_CC = ((TextBox)Action_Record.Rows[0].FindControl("NewRemarks")).Text;

       PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString() + "( CC --" + System.DateTime.Now.ToString("dd/MM/yyyy") + " -- " + Remarks_CC + ")|";
       
       
       if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
       {
           PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Approved_On"] = System.DateTime.Now;
           PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Approved_By"] = Session["UserName"].ToString();
       }


       bool result = Save();

       if (result)
       {

           if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
           {
               string subject = "";
               string msg = "";
               string to = "";

               DataSet ds = new DataSet();
               DataSet ds1 = new DataSet();
               BL_Send_Mail blobj = new BL_Send_Mail();
               ds = blobj.Get_Vendor_mail(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString());
               if (ds != null && ds.Tables[0].Rows.Count > 0)
               {
                   to = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
               }
               string v_name = "";

               ds1 = blobj.Get_Vendor_name(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString());
               if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
               {
                   v_name = ds1.Tables["App_vendor_reg"].Rows[0]["v_name"].ToString();
               }

               string v_code = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString();
               string remarks = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString();
               string wo_no = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"].ToString();



               subject = "Application of Work Order Exemption of work order no " + wo_no + " has been approved of M/S " + v_name + "(Vendor Code – " + v_code + ") ";
               msg = "<html><body><P><B>"
                   + "To<BR /> "
                   + v_name
                   + "<BR />" + v_code
                   + "<BR /><BR />Dear Sir/Madam"
                   + "<BR /> "

                   + "Based on submission of your documents and details, your application against the Work Order Exemption of work order no " + wo_no + " has been approved by Contractor Cell with remarks (" + remarks + ")."
                   + " <BR />Point is to be noted and recorded that approval is based on your details/documents which is submitted to us. "

                   + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
                   + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                   + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                   + " <BR /> "
                   + " <BR /> Note: Please do not reply as it is a system generated mail. ";




               BL_Send_Mail blobj1 = new BL_Send_Mail();
               blobj1.sendmail_approve(to, "", subject, msg, "");

           }
           else if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
           {



             





               string subject = "";
               string msg = "";
               string to = "";

               DataSet ds = new DataSet();
               DataSet ds1 = new DataSet();
               BL_Send_Mail blobj = new BL_Send_Mail();
               ds = blobj.Get_Vendor_mail(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString());
               if (ds != null && ds.Tables[0].Rows.Count > 0)
               {
                   to = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
               }
               string v_name = "";

               ds1 = blobj.Get_Vendor_name(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString());
               if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
               {
                   v_name = ds1.Tables["App_vendor_reg"].Rows[0]["v_name"].ToString();
               }

               string v_code = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString();
               string remarks = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString();
               string wo_no = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"].ToString();



               subject = "Application of Work Order Exemption of work order no " + wo_no + " has been approved of M/S " + v_name + "(Vendor Code – " + v_code + ") ";
               msg = "<html><body><P><B>"
                   + "To<BR /> "
                   + v_name
                   + "<BR />" + v_code
                   + "<BR />Dear Sir/Madam"
                   + "<BR /> "

                   + "Application against the Work Order Exemption of Work Order No " + wo_no + " has been retuned because of (" + remarks + "). Kindly resubmit the application along with correct data/ details/ attachments as per remarks given by Contractors’ Cell. "

                   + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
                   + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                   + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                   + " <BR /> "
                   + " <BR /> Note: Please do not reply as it is a system generated mail. ";




               BL_Send_Mail blobj1 = new BL_Send_Mail();
               blobj1.sendmail_approve(to, "", subject, msg, "");


           }

           PageRecordDataSet.Clear();
           WorkOrder_Exemption_Record.BindData();
           Action_Record.BindData();
           GetRecords(GetFilterCondition(), WorkOrder_Exemption_Records.PageSize, 10, "");
           WorkOrder_Exemption_Records.BindData();

           MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
           btnSave.Visible = false;
         
       }
   }
