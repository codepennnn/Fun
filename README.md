
 
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
                                                     <asp:CheckBoxList ID="WorkOrderNo" runat="server" DataMember="CC_Wo_No" DataSource="<%# PageDDLDataset %>"
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

  protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
  {


      GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
      WorkOrder_Exemption_Record.BindData();


      Dictionary<string, object> ddlParams = new Dictionary<string, object>();
      ddlParams.Add("ID", WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
      GetDropdowns("CC_Wo_No", ddlParams);





      Action_Record.DataBind();
}
 
 
 public DataSet GetDropdowns(string DropdownNames, Dictionary<string, object> ddlParam)
 {
     return DropDownHelper.GetDropDownsDataset(DropdownNames, ddlParam, true);
 }


  DDLQuery.Add("Exp_Wo_No", "SELECT value AS WorkOrderNo FROM App_WorkOrder_Exemption CROSS APPLY STRING_SPLIT(WorkOrderNo, ',') WHERE ID = @ID");
