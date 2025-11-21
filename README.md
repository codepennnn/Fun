   protected void btnSave_Click(object sender, EventArgs e)
   {



       WorkOrder_Exemption_Record.UnbindData();
       Action_Record.UnbindData();

       if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
       {


           string getFileName = "";
           List<string> FileList = new List<string>();
           if (((FileUpload)Action_Record.Rows[0].FindControl("ReturnAttachment")).HasFile)
           {
               foreach (HttpPostedFile htfiles in ((FileUpload)Action_Record.Rows[0].FindControl("ReturnAttachment")).PostedFiles)
               {
                   getFileName = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
                   getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                   htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
                   FileList.Add(getFileName);
               }
               PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ReturnAttachment"] = string.Join(",", FileList);
           }

       }







       string selectedWorkorder = string.Join(",", ((CheckBoxList)Action_Record.Rows[0].FindControl("CC_WorkOrderNo")).Items.
      Cast<ListItem>().Where(li => li.Selected).Select(li => li.Value));

       string Workordercomma = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["CC_WorkOrderNo"].ToString();
       string WorkOrderTrim = Workordercomma.TrimEnd(',');
       PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["CC_WorkOrderNo"] = WorkOrderTrim;



       //string Remarks_CC = ((TextBox)Action_Record.Rows[0].FindControl("NewRemarks")).Text;

       //PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString() + "( CC --" + System.DateTime.Now.ToString("dd/MM/yyyy") + " -- " + Remarks_CC + ")|";



      
           string Remarks_CC = NewRemarks.Text;

           PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].Rows[0]["Remarks"] = Remarks_CC;
           PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].Rows[0]["CreatedOn"] = System.DateTime.Now;
           PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].Rows[0]["Createdby"] = Session["UserName"].ToString();
           PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].Rows[0]["MASTER_ID"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"];
       

      





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



               //subject = "Application of Work Order Exemption of work order no " + wo_no + " has been approved of M/S " + v_name + "(Vendor Code – " + v_code + ") ";
               //msg = "<html><body><P><B>"
               //    + "To<BR /> "
               //    + v_name
               //    + "<BR />" + v_code
               //    + "<BR /><BR />Dear Sir/Madam"
               //    + "<BR /> "

               //    + "Based on submission of your documents and details, your application against the Work Order Exemption of work order no " + wo_no + " has been approved by Contractor Cell with remarks (" + remarks + ")."
               //    + " <BR />Point is to be noted and recorded that approval is based on your details/documents which is submitted to us. "

               //    + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
               //    + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
               //    + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
               //    + " <BR /> "
               //    + " <BR /> Note: Please do not reply as it is a system generated mail. ";


               subject = "Conditional Approval for Interim Bill Submission – M/s " + v_name +  " (Vendor Code: " + v_code + ") – Work Order No(s): " + wo_no;

               msg = "<html><body><p>"
                       + "<b>To:</b> M/s " + v_name + "<br/>"
                       + "<b>Vendor Code:</b> " + v_code + "<br/><br/>"
                       + "Dear Sir/Madam,<br/><br/>"
                       + "Your application submitted through the “WorkOrder Exemption (Billing)” module in CLMS for interim bill submission against Work Order No(s): "
                       + wo_no + " has been conditionally approved by the Contractors’ Cell.<br/><br/>"
                       + "<b>Remarks:</b> " + remarks + "<br/><br/>"
                       + "Please note that this approval is based on the documents and information provided by you.<br/>"
                       + "Kindly ensure that all compliance requirements are fulfilled within the stipulated time.<br/><br/>"
                       + "You may view the status of your application at: "
                       + "<a href='https://services.tsuisl.co.in/CLMS'>https://services.tsuisl.co.in/CLMS</a><br/><br/>"
                       + "For any queries, you may contact the Contractors’ Cell at 0657-6652063 / 6652064.<br/><br/>"
                       + "Thanks & Regards,<br/>"
                       + "<b>TATA Steel UISL</b><br/>"
                       + "<b>Contractors’ Cell</b><br/><br/>"
                       + "<i>Note: This is a system-generated email. Please do not reply.</i>"
                       + "</p></body></html>";





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



               //subject = "Application of Work Order Exemption of work order no " + wo_no + " has been approved of M/S " + v_name + "(Vendor Code – " + v_code + ") ";
               //msg = "<html><body><P><B>"
               //    + "To<BR /> "
               //    + v_name
               //    + "<BR />" + v_code
               //    + "<BR />Dear Sir/Madam"
               //    + "<BR /> "

               //    + "Application against the Work Order Exemption of Work Order No " + wo_no + " has been retuned because of (" + remarks + "). Kindly resubmit the application along with correct data/ details/ attachments as per remarks given by Contractors’ Cell. "

               //    + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
               //    + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
               //    + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
               //    + " <BR /> "
               //    + " <BR /> Note: Please do not reply as it is a system generated mail. ";


               subject = "Application Returned – Interim Bill Submission Request – M/s " + v_name + " (Vendor Code: " + v_code + ") – Work Order No(s): " + wo_no;

               msg = "<html><body><p>"
                 + "<b>To:</b> M/s " + v_name + "<br/>"
                 + "<b>Vendor Code:</b> " + v_code + "<br/><br/>"
                 + "Dear Sir/Madam,<br/><br/>"
                 + "Your application submitted through the “WorkOrder Exemption (Billing)” module in CLMS for interim bill submission against Work Order No(s): "
                 + wo_no + " has been <b>returned</b> by the Contractors’ Cell.<br/><br/>"
                 + "<b>Remarks:</b> " + remarks + "<br/><br/>"
                 + "You are requested to review the remarks and resubmit the application with the necessary corrections or additional information/documents.<br/><br/>"
                 + "You may access the application at: "
                 + "<a href='https://services.tsuisl.co.in/CLMS'>https://services.tsuisl.co.in/CLMS</a><br/><br/>"
                 + "For assistance, please contact the Contractors’ Cell at 0657-6652063 / 6652064.<br/><br/>"
                 + "Thanks & Regards,<br/>"
                 + "<b>TATA Steel UISL</b><br/>"
                 + "<b>Contractors’ Cell</b><br/><br/>"
                 + "<i>Note: This is a system-generated email. Please do not reply.</i>"
                 + "</p></body></html>";



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


    <cc1:FormCointainer ID="Action_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
        DataMember="App_WorkOrder_Exemption" DataKeyNames="ID" 
         
        BindingErrorMessage="aaaaaaaaa" GridLines="None">

        <Columns>
            <asp:TemplateField SortExpression="ID" Visible="False">
                <ItemTemplate>
                    <asp:Label ID="ID" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField>
                <ItemTemplate>

                    <div class="form-inline row">
                        <div class="form-group col-md-6 mb-1 mt-2">
                            <label for="Status" class="m-0 mr-0 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Action<span style="color: #FF0000;">*</span>:</label>
                            <asp:RadioButtonList ID="Status" runat="server" CssClass="form-check-input col-sm-8 radio" RepeatColumns="2" RepeatDirection="Horizontal" OnSelectedIndexChanged="Status_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="Approved">&nbsp&nbsp Approved</asp:ListItem>
                                <asp:ListItem Value="Return">&nbsp&nbsp Return</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="Status" ErrorMessage="Please Select Radiobutton !!" ValidationGroup="Save" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                    </div>
                    <br />

                    <div class="form-inline row">
                                <div id="div_exp_cc" runat="server" class="form-group col-md-4 mb-2">
                                    <label for="Exemption_CC" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">No. of Exemption days:<span style="color: #FF0000;">*</span></label>
                           
                                    <asp:TextBox ID="Exemption_CC" runat="server" CssClass="form-control form-control-sm col-sm-6" TextMode="Number"></asp:TextBox>
                           
                                    <asp:RegularExpressionValidator ID="RegValue" runat="server" ControlToValidate="Exemption_CC" ValidationExpression="^\d+$" ErrorMessage="Please enter a positive integer value." ValidationGroup="Save" ForeColor="Red" Font-Size="Medium"></asp:RegularExpressionValidator>
                                    <asp:CustomValidator ID="CustomValidator24" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Exemption_CC" ValidateEmptyText="true"></asp:CustomValidator>
                                </div>


    
                                
                                </div>



                        </div>






                    
                    <div class="form-inline row">
                    <div class="form-group col-md-2 mb-2" id="WoDiv" runat="server">
                    <label for="lblWorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">
                        WorkOrder No.: <span style="color: #FF0000;">*</span>
                    </label>
                         
                            <div class="SearchCheckBoxList" style="width:287%;">
                                <button class="btn btn-sm btn-default selectArea w-100" type="button" onclick="togglefloatDiv(this);" 
                                        id="btn-dwn1" style="border:0.5px solid #ced2d5;">
                                    <span class="filter-option float-left">No item Selected</span>
                                    <span class="caret"></span>
                                </button>
                                <div class="floatDiv" runat="server" style="border:1px solid #ced2d5; position:absolute; z-index:1000;
                                        box-shadow:0 6px 12px rgb(0 0 0 / 18%); background-color:white; padding:5px; display:none; width:100%;">
            
                                    <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control form-control-sm col-sm-6"  
                                                 oninput="filterCheckBox(this)" AutoComplete="off" ViewStateMode="Disabled" 
                                                 placeholder="Enter Workorder" Font-Size="Smaller" />
            
                                    <div style="overflow:auto; max-height:210px; overflow-y:auto; overflow-x:hidden;" class="searchList p-0">
                                        <asp:CheckBoxList ID="CC_WorkOrderNo" runat="server" DataMember="CC_Wo_No" DataSource="<%# PageDDLDataset %>"
                                                          DataTextField="WorkOrderNo" DataValueField="WorkOrderNo" CssClass="form-control-sm radio">
                                        </asp:CheckBoxList>
                                    </div>
            
                                    <asp:TextBox runat="server" ID="TextBox3" Width="0%" style="display:none" />
                                </div>
                            </div>
                              
                    </div>

                        </div>











                    <div id="div_ReturnAttachment" class="form-inline row mt-2" runat="server" visible="false">
                        <div class="form-group col-md-6 mb-2">
                            <label for="Return_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Return Attachment:</label>
                            <asp:FileUpload ID="ReturnAttachment" runat="server" AllowMultiple="true" Font-Size="Small" />
                            <asp:BulletedList ID="BulletedList1" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank" />


                        </div>

                    </div>


                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <PagerSettings Visible="False" />
    </cc1:FormCointainer>


    
                    <div class="form-inline row">

                        <div id="div_newRemarks" runat="server" class="form-group col-md-10 mb-2">
                            <label for="lblRemarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                            <asp:TextBox ID="NewRemarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="NewRemarks" ValidateEmptyText="true"></asp:CustomValidator>

                        </div>

                        </div>

                        i want to save remarks in my another table thats why i put this outside of form container because form container belongs to App_WorkOrder_exemption data table 
                        when i submit its showing 0 row position in  here PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"].Rows[0]["Remarks"] = Remarks_CC;
