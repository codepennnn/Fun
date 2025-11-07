<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true"  CodeBehind="Form_C3.aspx.cs" EnableEventValidation="false" Inherits="CLMS.App.Input.Form_C3"  MaintainScrollPositionOnPostback="true" %>
<%@ Register assembly="CustomControls" namespace="GridViewasContainer" tagprefix="cc1" %>
<%@ Register src="~/Control/MyMsgBox.ascx" tagname="MyMsgBox" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="Javascript" type="text/javascript">

        $(document).ready(function () {
            $('#myselection').on('change', function () {
                var demovalue = $(this).val();
                $("div.myDiv").hide();
                $("#show" + demovalue).show();
            });
        });

        function NumericChecking3digitLen(fld, fldlen) {
            if (isNaN(fld.value)) {
                alert("Please Enter Number Only !!! ");
                fld.form.reset();
                fld.focus();
                
                return false;
            }
            total_cal();
        }

        function WaterMarkFocus(txt, text) {
            if (txt.value == text) {
                txt.value = "";
                txt.style.color = "black";
            }
        }

        function WaterMarkBlur(txt, text) {
            if (txt.value == "") {
                txt.value = text;
                txt.style.color = "gray";
            }
        }


        function total_cal()
        {
            //alert("1");
            var sum_category = 0;

            var NO_OF_EMP_REG_0 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_0").value;
            if (NO_OF_EMP_REG_0 == '' || NO_OF_EMP_REG_0 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_0").value = 0;
            }
            var NO_OF_EMP_REG_1 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_1").value;
            if (NO_OF_EMP_REG_1 == '' || NO_OF_EMP_REG_1 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_1").value = 0;
            }
            var NO_OF_EMP_REG_2 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_2").value;
            if (NO_OF_EMP_REG_2 == '' || NO_OF_EMP_REG_2 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_2").value = 0;
            }
            var NO_OF_EMP_REG_3 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_3").value;
            if (NO_OF_EMP_REG_3 == '' || NO_OF_EMP_REG_3 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_3").value = 0;
            }
            var NO_OF_EMP_REG_4 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_4").value;
            if (NO_OF_EMP_REG_4 == '' || NO_OF_EMP_REG_4 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_4").value = 0;
            }

            var NO_OF_EMP_TEMP_0 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_0").value;
            if (NO_OF_EMP_TEMP_0 == '' || NO_OF_EMP_TEMP_0 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_0").value = 0;
            }
            var NO_OF_EMP_TEMP_1 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_1").value;
            if (NO_OF_EMP_TEMP_1 == '' || NO_OF_EMP_TEMP_1 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_1").value = 0;
            }
            var NO_OF_EMP_TEMP_2 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_2").value;
            if (NO_OF_EMP_TEMP_2 == '' || NO_OF_EMP_TEMP_2 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_2").value = 0;
            }
            var NO_OF_EMP_TEMP_3 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_3").value;
            if (NO_OF_EMP_TEMP_3 == '' || NO_OF_EMP_TEMP_3 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_3").value = 0;
            }
            var NO_OF_EMP_TEMP_4 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_4").value;
            if (NO_OF_EMP_TEMP_4 == '' || NO_OF_EMP_TEMP_4 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_4").value = 0;
            }



            for (var i = 0; i < 5; i++)
            {
                sum_category += parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                //alert(sum_category);
            }
            document.getElementById("MainContent_txtcal").value = sum_category;

            var ll_total = document.getElementById("MainContent_txtcal").value;
            
            var rem = document.getElementById("MainContent_Vendor_dtl_Record_LLWM_STRENGTH_0").value;
            //alert(rem);
            if (rem >= 0) {
                if (sum_category > rem) {
                    alert(" Sum of all the workman category is greater than the Remaining Workman Strength for which c3 can be applied or blank please select labour license number.");
                    document.getElementById("MainContent_txtcal").value = "";
                }
            } else
            {
                alert("Remaining Workman Strength for which c3 can be applied is blank or negative please select labour license number.");
                document.getElementById("MainContent_txtcal").value = "";
            }
            

        } 

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
    
    <div class="card m-2 shadow-lg" stye="position:center" >
        <div class="card-header bg-info text-light" stye="position:center">
            <h6 class="m-0">VENDOR FORM C3 REGISTRATION</h6>
        </div> 
    </div>

    
    <div id="Div1" runat="server" visible="true" stye="position:right">
        <ContentTemplate>
            <fieldset  id="searching_field" class="" style="border:1px solid #bfbebe;padding:5px 20px 5px 20px;border-radius:6px;overflow:auto" >            
                <div class="col-lg-4 mb-1 form-row">
                    <div class="col-md-5">
                    </div>
                    <div class="col-md-7">
                    </div>
                    <div class="col-md-5">
                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" Height ="24Px" >Work Order No :<span class="text-danger">*</span></label>
                    </div>
                    <div class="col-md-7">
                        <asp:DropDownList ID="Work_Order_No" runat="server" CssClass="form-control form-control-sm" 
                            DataSource="<%# PageDDLDataset %>" DataMember="VendorWorkOrderNo" DataTextField="WorkOrderNo"
                            DataValueField="WorkOrderNo"  OnSelectedIndexChanged="Work_Order_No_SelectedIndexChanged"
                            AutoPostBack="true" Font-Size="Small"></asp:DropDownList>

                    </div>
                </div>
            </fieldset>

            <div id="msg12" runat="server" visible="false">
            <fieldset  id="Message" class="" style="border:1px solid #bfbebe;padding:5px 20px 5px 20px;border-radius:6px;overflow:auto" >            
               <div class="card m-2 shadow-lg" stye="position:center" >
        <div class="card-header bg-info text-light" stye="position:center">
            <h6 class="m-0">C3 FORM PROGRESS MESSAGE AGREEMENT</h6>
        </div> 

          <div class="card-body pt-1">
              <div class="container-fluid">
                  <div class="row">
                      <asp:Label ID="Label1" runat="server" Class=" form-label" Font-Bold="true" ForeColor="#ff0000"></asp:Label>
                  </div>
                  
                  <div class="container-fluid pt-5">
                      <div class="row  ">
                          <div class="col-4">
                               <asp:Label ID="Label3" runat="server" Text="TSUISL/PEF/CWM/FOR/02" Class=" form-label" Font-Bold="true" ForeColor="black"></asp:Label>
                          </div>
                          <div class="col-4">
                               <a style="margin-left:48%"><asp:Label ID="Label4" runat="server" Text="REV. 00.04" Class=" form-label" Font-Bold="true" ForeColor="black" ></asp:Label></a>
                          </div>
                          <div class="col-4">
                               <a style="margin-left:30%"><asp:Label ID="Label5" runat="server" Text="EFFECTIVE DATE: 01/05/15" Class=" form-label" Font-Bold="true" ForeColor="black"></asp:Label></a>
                          </div>
                      </div>
                  </div>

                  <div class="row mt-5">
                      
                      <table style="width:100%;">
                          <tr >
                              <td style="font-weight: 700; font-size:small; color:white">TSUISL/PEF/CWM/FOR/02</td>
                              <td style="font-weight: 700; font-size: large; color:white ;text-align: center">REV. 00.04 </td>
                              <td style="text-align: left; color:white; font-weight: 700">EFFECTIVE DATE: 01/05/15</td>
                          </tr>
                          <tr>
                              <td>&nbsp;</td>
                              <td style="text-align: center; font-weight: 700; font-size: large; color: #000099">FORM – C1</td>
                              <td>&nbsp;</td>
                          </tr>
                          <tr>
                              <td>&nbsp;</td>
                              <td style="text-align: center; font-size: medium; font-weight: 700; color: #FF3300">DECLARATION BY THE CONTRACTOR</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                          <tr>
                              <td style="text-align: center">A.</td>
                              <td style="text-align: justify; font-size: large;" > We hereby declare and undertake that we will abide by all the Statutory Provisions and rules framed there under The Contract Labour Act (R&A) Act 1970 & rules 1972, The Minimum Wages Act 1948, The E.P.F. Act 1952, The ESI Act 1948, The Payment of Wages Act 1936, The Payment of Gratuity Act 1972, The Payment of Bonus Act 1965, The Bihar Industrial Establishment (National & Festival Holidays and Casual Leave) Act 1971, The Employees Compensation Act 1923, The Factory Act 1948, The Industrial Disputes Act 1947, The Building and Other Construction Workmen (RE & CS) Act 1996, Inter State Migrant Workmen Act,1979, Equal Remuneration Act 1976, The Child Labour Prohibition & Regulation Act 1986, The State Shops & Establishment Act 1953 and rules as applicable and any other laws/ rules as & when applicable.</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td style="text-align: center">B.</td>
                              <td style="text-align: justify; font-size: large;">Payment of employees engaged by us will be made positively between 7th/ 10th of day of every month or Weekly/ Fortnightly in presence of authorized representative of the principal employer or through bank payment and certification of the same at Contractors’ Cell/ HRIR Centers, in all cases whether the employment is of temporary/ permanent nature and receipt & all registers/ records will be submitted (uploaded into company compliance portal) by us to the Contractor Cell – Tata Steel UISL on or before 10th of every month for verification.</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              
                               <td style="text-align: center">C.</td>
                              <td style="text-align: justify; font-size: large;">All categories of contract labours shall be paid according to schedule of rates as per Appropriate Government Notification i.e not less than prescribed minimum wages.</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td style="text-align: center">D.</td>
                              <td style="text-align: justify; font-size: large;">All contract employees/ workforces will be issued Employment Card/ Attendance Card/ Photo I.D. Card and Service Certificate during course of the employment (Entry to Exit).</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td style="text-align: center">E.</td>
                              <td style="text-align: justify; font-size: large;" >PF & ESI Contributions amount to be deposited in the Bank on or before by 15th of every month and receipt & all registers/ records will be submitted (uploaded into company compliance portal) by us to the Contractor Cell – Tata Steel UISL on or before 20th of every month for verification.</td>
                              <td>&nbsp;</td>
                          </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                            <tr>
                              <td style="text-align: center">F.</td>
                              <td style="text-align: justify; font-size: large;">Day one, we will ensure that all contract workforces will have PF No & ESI No. & Temporary ESI cards to be issued to them, they will have bank a/c (saving or salary) to ensure monthly labour payment/ any legitimate dues through bank only. In absence of this, we will not be able to get gate passes.</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td style="text-align: center">G.</td>
                              <td style="text-align: justify; font-size: large;"> We will ensure that Worker’s Grievances or Govt.  Notices will be closed within due/ specified date to avoid payment hold or consequence management by the company.</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td style="text-align: center">H</td>
                              <td style="text-align: justify; font-size: large;">We will ensure that all contract workforces shall be paid leave/ bonus (if they are eligible / entitled) on yearly basis or at the time of closure of work/ work orders. </td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                              <tr>
                              <td style="text-align: center">I</td>
                              <td style="text-align: justify; font-size: large;">Full & Final settlement of workmen shall be done within 48 hours, if they left/ terminated/job completed</td>
                              <td>&nbsp;</td>
                          </tr>
                           <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                              <tr>
                              <td style="text-align: center">J</td>
                              <td style="text-align: justify; font-size: large;">	We will apply for N.O.C. from Contractors' Cell before submitting final bill / retention money against each work order</td>
                              <td>&nbsp;</td>
                          </tr>
                          <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                            
                              <tr>
                              <td style="text-align: center">K</td>
                              <td style="text-align: justify; font-size: large;">We will keep the registers/ records updated of all related statutory provisions for inspection and verification on demand by the Contractor Cell or authorized representative of Government officers any time.</td>
                              <td>&nbsp;</td>
                          </tr> 
                          <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                              <tr>
                              <td style="text-align: center">L</td>
                              <td style="text-align: justify; font-size: large;">We also undertake that we will maintain all documents, returns & forms as per above Act & Rules.</td>
                              <td>&nbsp;</td>
                          </tr>
                          <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                          <tr>
                              <td style="text-align: center">M</td>
                              <td style="text-align: justify; font-size: large;">In the event of any non-compliance on our part the Tata Steel UISL, beside other things, the company will be entitled to terminate the Contract without assigning any reason and to withhold payment against our bills with a view to indemnify themselves against any liability that may have to suffer in consequences of any non-compliance.</td>
                              <td>&nbsp;</td>
                          </tr>

                              <tr>
                              <td>&nbsp;</td>
                              <td >&nbsp;</td>
                              <td>&nbsp;</td>
                          </tr>
                          
                      </table>
                      <div class="container">
                          <div class="row">
                          <div class="col-4 form-row">
                              <div class="col-6">
                                  <asp:Label ID="Label2" runat="server" Text="Vendor Code:" Class="form-label"></asp:Label>
                              </div>
                              <div class="col-6">
                                  <asp:TextBox ID="TextBox1" runat="server" Class="form-control" ReadOnly="true"></asp:TextBox>
                              </div>
                          </div>

                           <div class="col-4 form-row">
                              <div class="col-6">
                                  
                              </div>
                              <div class="col-6">
                                  <asp:Button ID="Button1" runat="server" Text="Don't Agree" Class="btn btn-danger" OnClick="Button1_Click" />
                              </div>
                          </div>


                          <div class="col-4 form-row">
                              <div class="col-6">
                                  
                              </div>
                              <div class="col-6">
                                  <asp:Button ID="Button2" runat="server" Text="I Agree" Class="btn btn-success" OnClick="Button2_Click"  />
                              </div>
                          </div>
                              </div>
                      </div>
                  </div>
              </div>
              </div>
    </div>
            </fieldset>
                </div>
        </ContentTemplate>
    </div>

    <%--Display Vendor details after selection of work order no wise--%>
        <%--<asp:UpdatePanel>
            <ContentTemplate>--%>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>

                <div id="Div_vendor_dtl" runat="server" visible="true" stye="position:center">
                    <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px; position: center">
                        <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Vendor Details </b></legend>
                        <cc1:FormCointainer ID="Vendor_dtl_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
                            DataMember="App_Vendor_form_C3_Dtl" DataKeyNames="ID" OnNewRowCreatingEvent="Vendor_dtl_Record_NewRowCreatingEvent1"
                            OnPreRender="Vendor_dtl_Record_PreRender" BindingErrorMessage="Project Master InPut OutPut" GridLines="None"
                            BorderStyle="Solid" BorderWidth="1px" BorderColor="#bfbebe">
                            <Columns>
                                <asp:TemplateField SortExpression="ID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="ID" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Vendor Code :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="V_CODE" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="V_CODE" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Name of Firm :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="V_NAME" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="100" />
                                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="V_NAME" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>


                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Address :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="ADDRESS" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="200" />
                                                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="ADDRESS" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Owner / Director Name :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="OWNER_NAME" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false"  />
                                                    <asp:CustomValidator ID="CustomValidator6" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="OWNER_NAME" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Phone No. :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="PHONE_NO" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                    <asp:CustomValidator ID="CustomValidator7" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="PHONE_NO" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Email ID :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="EMAIL_ID" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="100" />
                                                    <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="EMAIL_ID" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                        </div>

                                        <div>
                                            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Vendor Pf/Esi Details </b></legend>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Pf Code. :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="PF_CODE" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Esi Code :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="ESI_CODE" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Mode of Payment :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="form-group col-md-5 mb-1">
                                                    <asp:DropDownList ID="NATURE_OF_PAYMENT" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;">
                                                        <asp:ListItem Text="Bank" Value="Bank" />
                                                        <asp:ListItem Text="Chaque" Value="Chaque" />
                                                        <asp:ListItem Text="Cash" Value="Cash" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Type of Payment :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="form-group col-md-5 mb-1">
                                                    <asp:DropDownList ID="TYPE_OF_PAYMENT" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;">
                                                        <asp:ListItem Text="Monthly" Value="Monthly" />
                                                        <asp:ListItem Text="Fortnightly" Value="Fortnightly" />
                                                        <asp:ListItem Text="Weekly" Value="Weekly" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">ESI Applicable: :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="form-group col-md-5 mb-1">
                                                    <asp:DropDownList ID="ESI_APP" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;">
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                        <asp:ListItem Text="No" Value="No" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">PRW Applicable: :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="form-group col-md-5 mb-1">
                                                    <asp:DropDownList ID="PRW_APP" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;">
                                                        <asp:ListItem Text="No" Value="No" />
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Wages/PF/ESI Payment Details :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="form-group col-md-5 mb-1">
                                                    <asp:DropDownList ID="WAGES_PF_ESI_DETAIL" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;">
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                        <asp:ListItem Text="No" Value="No" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Remarks :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="MV_REMARKS" runat="server" CssClass="form-control form-control-sm textboxstyle" MaxLength="200" />
                                                </div>
                                            </div>

                                        </div>

                                        <div>
                                            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Vendor Authorized Representative Details </b></legend>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Name :<span class="text-danger"></span></label>
                                                </div>

                                                <div class="col-md-7">
                                                    <asp:DropDownList ID="AUTHOR_NAME" runat="server" CssClass="form-control form-control-sm"
                                                        DataSource="<%# PageDDLDataset %>" DataMember="vendor_representative" DataTextField="NAME"
                                                        DataValueField="NAME"  OnSelectedIndexChanged="AUTHOR_NAME_SelectedIndexChanged"
                                                        AutoPostBack="true" Font-Size="Small" OnPreRender="DDLicNo_PreRender" OnDataBound="AUTHOR_NAME_DataBound">
                                                    </asp:DropDownList>
                                                </div>



                                               <%-- <div class="col-lg-7">
                                                    <asp:TextBox ID="AUTHOR_NAME" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" />
                                                </div>--%>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Email Id :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="AUTHOR_EMAIL" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="100" />
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Contact No :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="AUTHOR_CONTACT_NO" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Adhar Number :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="AUTHOR_ADHAR_NUMBER" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                </div>
                                            </div>


                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Address :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="AUTHOR_ADDRESS" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="200" />
                                                </div>
                                            </div>

                                        </div>

                                        <div>
                                            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Vendor WorkOrder Details </b></legend>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Work Order No. :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="WO_NO" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                    <asp:CustomValidator ID="CustomValidator9" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="WO_NO" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Doc. Date :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="DOC_DATE" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" />
                                                    <asp:CustomValidator ID="CustomValidator10" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="DOC_DATE" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Period Of Contract (from) :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="PERIOD_CONTRACT_FROM" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" />
                                                    <%--PERIOD_CONTRACT_FROM--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Period Of Contract (To) :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="PERIOD_CONTRACT_TO" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" />
                                                    <%--PERIOD_CONTRACT_TO--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Nature of Work :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="NATURE_OF_WORK" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" TextMode="MultiLine" />
                                                    <%--NATURE_OF_WORK--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Date Commencement of Work :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="COMMENCEMENT_DATE_OF_WORK" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" />
                                                    <%--COMMENCEMENT_DATE_OF_WORK--%>
                                                    <ask:CalendarExtender ID="CalendarExtender_1" runat="server" Enabled="false" Format="dd/MM/yyyy" TargetControlID="COMMENCEMENT_DATE_OF_WORK" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                                                    <asp:CustomValidator ID="CustomValidator_1" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save"  ControlToValidate="COMMENCEMENT_DATE_OF_WORK" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Location of Work :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="LOCATION_OF_WORK" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="200"  />
                                                    <%--LOCATION_OF_WORK--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Department:<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="DEPARTMENT" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="100"  />
                                                    <%--DEPARTMENT--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Work Order Value:<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="WO_VALUE" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50"  />
                                                    <%--WO_VALUE--%>
                                                    <%--<asp:CustomValidator ID="CustomValidator17" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="WO_VALUE" ValidateEmptyText="true"></asp:CustomValidator>--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Monthly Validation Applicable:<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:DropDownList ID="MONTHLY_VALIDATION_APP" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;">
                                                        <%--MONTHLY_VALIDATION_APP--%>
                                                        <asp:ListItem Text="YES" Value="YES" />
                                                        <asp:ListItem Text="NO" Value="NO" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Remarks :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="PF_ESI_CODE_REMARKS" runat="server" CssClass="form-control form-control-sm textboxstyle" MaxLength="200"  />
                                                    <%--PF_ESI_CODE_REMARKS--%>
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>BOCW REGISTRATION </b></legend>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Registration No :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="REGIS_NUMBER" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="50" />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Registration Date :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="REGIS_DATE" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" />
                                                    <ask:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy" TargetControlID="REGIS_DATE" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                                                    <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="REGIS_DATE" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Registration Valid Upto :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="REGIS_VALID_UPTO" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" />
                                                    <ask:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy" TargetControlID="REGIS_VALID_UPTO" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                                                    <asp:CustomValidator ID="CustomValidator11" runat="server" ClientValidationFunction="Validate" ValidationGroup="BtnSave" ControlToValidate="REGIS_VALID_UPTO" ValidateEmptyText="true"></asp:CustomValidator>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Total No. of Employees for which BOCW obtained :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="NO_EMP_BOCW_OBTAINED" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" MaxLength="50"  />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-lg-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Remarks :<span class="text-danger"></span></label>
                                                </div>
                                                <div class="col-lg-7">
                                                    <asp:TextBox ID="BOCW_REMARKS" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" MaxLength="200" />
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Labour License No </b></legend>
                                        </div>

                                        <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>--%>
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-md-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" height="24Px">Location :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-md-7">
                                                   <%-- <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"  CssClass="form-control form-control-sm" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1">
                                                        <%--MONTHLY_VALIDATION_APP--%>
                                                       <%-- <asp:ListItem Text="Please Select" Value="" />
                                                        <asp:ListItem Text="Jamshedpur" Value="Jamshedpur" />
                                                        <asp:ListItem Text="Seraikela" Value="Seraikela" />
                                                        <asp:ListItem Text="Others" Value="Others" />
                                                    </asp:DropDownList>--%>

                                                     <asp:TextBox ID="Labour_License_site" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" MaxLength="20"   />


                                                </div>
                                            </div>
                                            <%--GK--%>
                                        <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-md-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" height="24Px">Principal Employeer :</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <asp:DropDownList ID="PE" runat="server"  DataSource="<%# PageDDLDataset %>" DataMember="PE" DataTextField="PE"
                                                        DataValueField="PE"  CssClass="form-control form-control-sm" />
                                                    <asp:CustomValidator ID="CustomValidator8" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="PE" ValidateEmptyText="true"></asp:CustomValidator>
                                                    
                                                </div>
                                            </div>
                                            <div class="col-lg-4 mb-1 form-row" >
                                                <div class="col-md-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" height="24Px">Work Location :</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <asp:DropDownList ID="WorkLoc" runat="server" OnSelectedIndexChanged="WorkLoc_SelectedIndexChanged"  DataSource="<%# PageDDLDataset %>" DataMember="Locations" 
                                                    DataTextField="Location" DataValueField="LocationCode" AutoPostBack="true" CssClass="form-control form-control-sm" />
                                                    <asp:CustomValidator ID="CustomValidator12" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="WorkLoc" ValidateEmptyText="true"></asp:CustomValidator>
                                                     
                                                </div>
                                            </div>

                                             
                                        </div>
                                      <%--GK --%>
                                        </div>

                                        
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-md-5">
                                                    <%--<label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" height="24Px">License :<span class="text-danger">*</span></label>--%>
                                                </div>
                                                <div class="col-md-7">
                                                    <asp:DropDownList ID="DDLICENCE" runat="server" OnSelectedIndexChanged="DDLICENCE_SelectedIndexChanged"
                                                        AutoPostBack="true" CssClass="form-control form-control-sm col-sm-6" Style="width: auto;" Visible ="false">
                                                        <asp:ListItem Text="Please Select" Value="0" />
                                                        <asp:ListItem Text="SELF" Value="1" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                             
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-md-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" height="24Px">Labour License No :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-md-7">
                                                    <asp:DropDownList ID="DDLicNo" runat="server" CssClass="form-control form-control-sm"
                                                        DataSource="<%# PageDDLDataset %>" DataMember="VendorLicNo" DataTextField="Validity"
                                                        DataValueField="LicNo" OnSelectedIndexChanged="DDLicNo_SelectedIndexChanged" 
                                                        AutoPostBack="true" Font-Size="Small" OnPreRender="DDLicNo_PreRender" >
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 mb-1 form-row">
                                                <div class="col-md-5">
                                                    <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" height="24Px">Company LL No. :<span class="text-danger">*</span></label>
                                                </div>
                                                <div class="col-md-7">
                                                     <asp:DropDownList ID="companyLL" runat="server" CssClass="form-control form-control-sm" 
                                                        DataSource="<%# PageDDLDataset %>" DataMember="Company1" DataTextField="Validity"
                                                        DataValueField="LLno" Font-Size="Small" >
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                         
                                        <div id="Div_lab_lic" runat="server" visible="true" stye="position:center">
                                            <div class="row">
                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Nature Of Labour License :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="NATURE_OF_LL" runat="server" CssClass="form-control form-control-sm textboxstyle" Enabled="false" TextMode="MultiLine" MaxLength="150" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Valid from :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="LL_VALID_FROM" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Valid Upto :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="LL_VALID_UPTO" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Total No. of Employees for which Labour License obtained :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="TOTAL_WORKMAN" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" MaxLength="50"/>
                                                    </div>
                                                </div>


                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Department Name :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="Deptcode" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" MaxLength="50" />
                                                    </div>
                                                </div>
                                                <%--<div class="col-lg-4 mb-1 form-row" id="PEText" runat="server">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Principal Employer :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="PE" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 mb-1 form-row" id="WLText" runat="server">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Work Location :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="WorkLoc" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" />
                                                    </div>
                                                </div>--%>

                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Nature of Work :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="Nature" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px" Enabled="false" MaxLength="50" />
                                                    </div>
                                                </div>



                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Remaining Workman Strength for which c3 can be applied :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="LLWM_STRENGTH" runat="server" CssClass="form-control form-control-sm textboxstyle" Height="24Px"  Enabled="false" />
                                                    </div>
                                                </div>





                                                <div class="col-lg-4 mb-1 form-row">
                                                    <div class="col-lg-5">
                                                        <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Remarks  :<span class="text-danger"></span></label>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="LL_REMARKS" runat="server" CssClass="form-control form-control-sm textboxstyle" MaxLength="200" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                               
                                                <%--</ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DDLicNo" />
                                                <asp:AsyncPostBackTrigger ControlID="companyLL" />
                                                <asp:PostBackTrigger ControlID="DropDownList1" />
                                            </Triggers>
                                            </asp:UpdatePanel>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Visible="False" />
                        </cc1:FormCointainer>
                    </fieldset>
                </div>
                                                </ContentTemplate>
                                           <%-- <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DDLicNo" />
                                                <asp:AsyncPostBackTrigger ControlID="companyLL" />
                                                <asp:PostBackTrigger ControlID="DropDownList1" />
                                            </Triggers>--%>
                                            </asp:UpdatePanel>
            <%--</ContentTemplate>
        </asp:UpdatePanel>--%>



        

    <%-- VENDOR WORKMEN EMPLOYED CONTRACTOR DETAILS Entry Form--%>
        <fieldset id="workman_emp_calculate"  runat="server" class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px; overflow: auto">
            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>DETAILS OF WORKMEN EMPLOYED BY THE CONTRACTOR</b></legend>
            <div id="div_vendor" runat="server" class="form-inline row">
                <div style="width: 100%; border-style: solid; border-width: 1px; border-color: #bfbebe">

                   <%-- <div style="width: 100%; background-color: Silver; height: 32px; border-top-color: #00000024; border-top-style: solid; border-bottom-width: 1px">
                        <span style="font-weight: bold; font-size: medium; text-align: center"><a style="color: black"></a></span>
                        <asp:Label ID="Label4" runat="server" Text="Click to add Skill wise Workman Details"> </asp:Label>
                        <asp:Button ID="btnadded" runat="server" Text="+" OnClick="btnadded_Click" CssClass="btnAdd" Width="25px" Height="25px" BackColor="#17a2b8" />
                    </div>--%>


                    




                    <cc1:DetailsContainer ID="workers_Records" runat="server" AutoGenerateColumns="False" 
                        AllowPaging="true" CellPadding="4" GridLines="None" Width="100%" DataMember="App_Vendor_FormC3_WorkManCat"
                        DataKeyNames="ID" DataSource="<%# PageRecordDataSet %>" OnDataRowAddingEvent="workers_Records_DataRowAddingEvent"
                        ShowHeaderWhenEmpty="True" 
                        PageSize="10" PagerSettings-Visible="True" PagerStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#f19c50"
                        PagerStyle-Wrap="False" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller">
                        <Columns>
                            <asp:TemplateField SortExpression="ID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="ID" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EMP TYPE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:TextBox ID="EMP_TYPE" runat="server" CssClass="form-control form-control-sm textboxstyle" Width="100%" Enabled="false"  ></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="NO OF EMP REG" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:TextBox ID="NO_OF_EMP_REG" runat="server" CssClass="form-control form-control-sm textboxstyle" Width="100%" onchange="return NumericChecking3digitLen(this,3)"
                                        ToolTip="Enter Number Only" Text="0"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="NO OF EMP TEMP" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:TextBox ID="NO_OF_EMP_TEMP" runat="server" CssClass="form-control form-control-sm textboxstyle" Width="100%" onchange="return NumericChecking3digitLen(this,3)"
                                        ToolTip="Enter Number Only" Text="0"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:TextBox ID="REMARKS" runat="server" CssClass="form-control form-control-sm textboxstyle" Width="100%" ToolTip="Enter Remarks"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </cc1:DetailsContainer>


                  

                    




                </div>
            </div>
        </fieldset>
        <div>
            
        </div>

    <%--Save and delete Buttom--%>
        <div id="totalwork" runat="server" class="row m-0 justify-content-center mt-2">
            <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Total Workman:<span class="text-danger"></span></label>
            <asp:TextBox ID="txtcal" runat ="server" BorderStyle ="Groove"  Width ="50Px" onchange="return NumericChecking3digitLen(this,3)" ></asp:TextBox>
            <asp:CustomValidator ID="CustomValidator19" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="txtcal" ValidateEmptyText="true"></asp:CustomValidator>
            <%--<asp:Button ID="btncalculate" runat="server" Text="calculate"  OnClientClick="javascript:total_cal()"  /> <%--Visible ="false"--%>
        </div>
        <div class="row m-0 justify-content-center mt-2">

            <asp:Button ID="btnSave" runat="server" Text="Submit" OnClick="btnSave_Click" CssClass="btn btn-sm btn-info" ValidationGroup="Save" Visible ="false" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="false" OnClick="btnDelete_Click"
                CssClass="btn btn-sm btn-danger ml-1" OnClientClick="if(confirm('Do you want to Delete the selected record'))return true;else return false;" />
        </div>

    <%--Message box--%>
        <div>
            <uc1:MyMsgBox ID="MyMsgBox" runat="server" />
        </div>


</div>
</asp:Content>
