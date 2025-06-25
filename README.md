   <div class="form-group col-lg-2 col-md-4 mb-1">
        <div class="">
            <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" >Work Order :<span class="text-danger">*</span></label>
        </div>
        <div class="">
             <asp:DropDownList ID="Work_Order_No" runat="server" CssClass="form-control form-control-sm" 
                DataSource="<%# PageDDLDataset %>" DataMember="app_formc3" DataTextField="wo_no"
              DataValueField="wo_no" 
              AutoPostBack="true" Font-Size="Small"></asp:DropDownList>
        </div>
   </div>
