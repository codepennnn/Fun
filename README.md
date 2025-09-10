  <cc1:formcointainer ID="WorkOrder_Exemption_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnNewRowCreatingEvent="WorkOrder_Exemption_Record_NewRowCreatingEvent"
                           PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>" 
                          DataMember="App_WorkOrder_Exemption" DataKeyNames="ID" 
                           BindingErrorMessage="aaaaaaaaa" GridLines="None"  OnPreRender="WorkOrder_Exemption_Record_PreRender" OnRowDataBound="WorkOrder_Exemption_Record_RowDataBound">
                           
                        <Columns>
                            <asp:TemplateField SortExpression="ID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="ID" runat="server" ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                <%--OnRowDataBound="WorkOrder_Exemption_Record_RowDataBound"--%>
                       
                                  <div class="form-inline row">

                                       <div class="form-group col-md-6 mb-1">
                                        <label for="VendorCode" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Vendor Code:<span style="color: #FF0000;">*</span></label>
                                        <asp:TextBox ID="VendorCode" runat="server" CssClass="form-control form-control-sm col-sm-6"  Enabled="false" ></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="VendorCode" ValidateEmptyText="true"></asp:CustomValidator>

                                     </div>

                                      <div class="form-group col-md-6 mb-1">
                                        <label for="VendorName" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Vendor Name:<span style="color: #FF0000;">*</span></label>
                                        <asp:TextBox ID="VendorName" runat="server" CssClass="form-control form-control-sm col-sm-6" Enabled="false"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="VendorName" ValidateEmptyText="true"></asp:CustomValidator>

                                     </div>
                                       </div>










                                    <div class="form-inline row">

                                        

                                       <%--<div class="form-group col-md-6 mb-1">
                                        <label for="WorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">WorkOrder No.:
                                            <span style="color: #FF0000;">*</span></label>
                                        <asp:DropDownList ID="WorkOrderNo" runat="server" CssClass="form-control form-control-sm col-sm-6" DataMember="Exp_Wo_No" 
                                            DataSource="<%# PageDDLDataset %>" DataTextField="Workorder" DataValueField="WO_NO" SelectionMode="Multiple" >
                                            </asp:DropDownList>

                                     </div>--%>

                                      
                              <div class="form-group col-md-6 mb-2">
                                       <label for="lblWorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5  font-weight-bold fs-6 justify-content-start">WorkOrder No.:
                                           <span style="color: #FF0000;">*</span></label>
                                           <div class="form-group col-md-6 mb-2" style="margin-left:-14px">
                                            <div>
                                          <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <div class="SearchCheckBoxList" style="width:287%;">
                                                          <button class="btn btn-sm btn-default selectArea w-100" type="button"  onclick="togglefloatDiv(this);" 
                                                              id="btn-dwn1" style="border:0.5px solid #ced2d5;">
                                                      <span  class="filter-option float-left">No item Selected</span>
                                                            <span class="caret" ></span>
                                                          </button>
                                                          <div class="floatDiv" runat="server"  style="border:1px solid #ced2d5;position:absolute;z-index:1000;
                                                            box-shadow:0 6px 12px rgb(0 0 0 / 18%);background-color:white;padding:5px;display:none;width:100%;">
                                                           <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control form-control-sm col-sm-12" 
                                                               oninput="filterCheckBox(this)" AutoComplete="off" ViewStateMode="Disabled" placeholder="Enter Workorder" Font-Size="Smaller" />
                                                    <div  style="overflow:auto;max-height:210px;overflow-y:auto;overflow-x:hidden"; class="searchList p-0" >
                                                                  <asp:CheckBoxList ID="WorkOrderNo" runat="server" DataMember="Exp_Wo_No" DataSource="<%# PageDDLDataset %>"
                                                                       DataTextField="Workorder"
                                                                     DataValueField="WO_NO"  CssClass="form-control-sm radio" >
                                             </asp:CheckBoxList>

                                                           </div>
                                                              <asp:TextBox runat="server" ID="TextBox3"  Width="0%" style="display:none" />
                                            </div>
                                                      </div>
                                                </ContentTemplate>
                                               </asp:UpdatePanel>
                                             </div>
                                          </div>
                              </div>

                                         







                                      <div class="form-group col-md-6 mb-1">
                                        <label for="Exemption_Vendor" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">No. Of Exemption Days:<span style="color: #FF0000;">*</span></label>
                                      
                                          <asp:TextBox ID="Exemption_Vendor" runat="server" CssClass="form-control form-control-sm col-sm-6" TextMode="Number"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Exemption_Vendor" ValidateEmptyText="true"></asp:CustomValidator>
                                          <asp:RegularExpressionValidator ID="RegValue" runat="server" ControlToValidate="Exemption_Vendor" ValidationExpression="^\d+$" ErrorMessage="Please enter a positive integer value." ValidationGroup="Save" ForeColor="Red" Font-Size="Medium" ></asp:RegularExpressionValidator>
                                     </div>


                                        <div class="form-group col-md-12 mb-1">


                                               <label for="lblComplianceType" class="m-0 mr-5 p-0 col-form-label-sm col-sm-2  font-weight-bold fs-6 justify-content-start">Compliance Type:
                                                     <span style="color: #FF0000;">*</span>
                                                </label>


                                                <asp:CheckBoxList ID="ComplianceType" runat="server" 
                                                                     CssClass="form-control-sm radio col-sm-5"
                                                                     RepeatDirection="Horizontal">
                                                    <asp:ListItem> Wage</asp:ListItem>
                                                    <asp:ListItem> PF & ESI</asp:ListItem>
                                                    <asp:ListItem> Leave</asp:ListItem>
                                                    <asp:ListItem> Bonus</asp:ListItem>
                                                    <asp:ListItem> Labour License</asp:ListItem>
                                                    <asp:ListItem> Grievance</asp:ListItem>
                                                    <asp:ListItem> Notice</asp:ListItem>
                                                </asp:CheckBoxList>


                                            </div>







                                       </div>

                



                                           

                                        








                                      <div class="form-inline row">
                                        <div class="form-group col-md-8 mb-3">
                                        <label for="Remarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                                         <asp:TextBox ID="Remarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Remarks" ValidateEmptyText="true"></asp:CustomValidator>

                                        </div> 
                                     </div>

                                     <div class="form-inline row">
                                          <div class="form-group col-md-6 mb-2">
                                                <label for="lbl_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start" >Attachment:</label>
                                        <asp:FileUpload ID="Attachment" runat="server" AllowMultiple="true" Font-Size="Small"/>
                                        <asp:BulletedList ID="Bull_Attach" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank"/>

                         
                                             <%--   <asp:Button ID="btndownload" runat="server" Text="Download" OnClick="btndownload_Click" />--%>
                                              </div>

                                 

                                        </div>
                               

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerSettings Visible="False" />
                    </cc1:formcointainer>



                               protected void btnSave_Click(object sender, EventArgs e)
        {
            string selectedWorkorder = string.Join(",", ((CheckBoxList)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Items.
            Cast<ListItem>().Where(li => li.Selected).Select(li => li.Value));

            //PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"] = selectedWorkorder;


            string strRemarks = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString();
            WorkOrder_Exemption_Record.UnbindData();
            BL_WorkOrder_Exemption blobj = new BL_WorkOrder_Exemption();

            string Workordercomma = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"].ToString();
            string WorkOrderTrim = Workordercomma.TrimEnd(',');
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"] = WorkOrderTrim;

            string getFileName = "";
            List<string> FileList = new List<string>();
            if (((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).HasFile)
            {
                foreach (HttpPostedFile htfiles in ((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).PostedFiles)
                {
                    getFileName = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
                    getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                    htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
                    FileList.Add(getFileName);
                }
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Attachment"] = string.Join(",", FileList);
            }
              PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"] = "Pending With CC";

            if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0].RowState.ToString() == "Modified")
            {
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ResubmittedOn"] = System.DateTime.Now;
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ResubmittedBy"] = Session["UserName"].ToString();
            }

            if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString() == "")
            {
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"] = strRemarks + "( VENDOR --" + System.DateTime.Now.ToString("dd/MM/yyyy")
                    + " -- " + ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Text + ")|";
            }
            else
            {
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"] = strRemarks + "( VENDOR --" + System.DateTime.Now.ToString("dd/MM/yyyy")
                    + " -- " + ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Text + ")|";
            }


            //validation for checkboxlist
            int count = 0;
                foreach (ListItem lstitem in ((CheckBoxList)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Items)
                {
                if (lstitem.Selected == true)
                    count++;
                }
                if (count==0)
                {
                
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Please Select atleast one workorder no. !!");
                return;
                }
          

            bool result = Save();

            if (result)
            {

                string v_code = Session["UserName"].ToString();
                string v_name = "";
                string wo_no = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"].ToString();
                string subject = "";
                string msg = "";
                string cc = "";
                DataSet ds = new DataSet();
                DataSet ds1 = new DataSet();
                BL_Send_Mail blobj1 = new BL_Send_Mail();
                ds = blobj1.Get_Vendor_mail(Session["UserName"].ToString());
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    cc = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
                }

                ds1 = blobj1.Get_Vendor_name(v_code);
                if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
                {
                    v_name = ds1.Tables["App_vendor_reg"].Rows[0]["v_name"].ToString();
                }



                subject = "Application for WorkOrder Exemption has been submitted or updated by M/S  " + v_name + " (Vendor Code – " + v_code + " ) ";
                msg = "<html><body><P><B>" 
                              + "To<BR /> "
                              + "Contractor Cell <BR/>"
                              + "<BR />Dear Sir/Madam"
                              + "<BR /> "

                              + "M/s " + v_name + " (" + v_code + ") has submitted Work Order Registration application against Work Order " + wo_no + ", request you to please do the needful as soon as possible.<BR/>"

                              + "<BR />Link :- https://services.tsuisl.co.in/CLMS "
                              + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                              + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                              + " <BR /> "
                              + " <BR /> Note: Please do not reply as it is a system generated mail. ";


                blobj1.sendmail_request("", cc, subject, msg, "");





















                PageRecordDataSet.Clear();
                WorkOrder_Exemption_Record.BindData();
                GetRecords(GetFilterCondition(), WorkOrder_Exemption_Records.PageSize, 10, "");
                WorkOrder_Exemption_Records.BindData();

                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
                btnSave.Visible = false;
                DivInputFields.Visible = false;

            }
            else
            {
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
            }
        }

