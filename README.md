 protected void MonthWage_SelectedIndexChanged(object sender, EventArgs e)
 {
    

     Dictionary<string, object> ddlParams = new Dictionary<string, object>();
   
     Month.SelectedValue = DateTime.Now.Month.ToString();
     Year.Text = DateTime.Now.Year.ToString();
     ddlParams.Add("vendorcode", Session["UserName"].ToString());
     ddlParams.Add("MonthWage", Month.SelectedValue.ToString());
     ddlParams.Add("YearWage", Year.Text.ToString());

     GetDropdowns("Locations_jhar_report", ddlParams);

     LocationCode.DataBind();


 }


        protected void Page_Load(object sender, EventArgs e)
       {
           if (!IsPostBack)
           {
               //ReportViewer1.Visible = false;
               // ReportViewer1.Style.Add("display", "none");
               ReportViewer3.Visible = false;

               // All DropDown
               Dictionary<string, object> ddlParams = new Dictionary<string, object>();
               ddlParams.Add("VCode", Session["UserName"].ToString()); 
               ddlParams.Add("V_CODE", Session["UserName"].ToString()); 
               ddlParams.Add("Location", "abc");
               ddlParams.Add("LocationNM", "abc");
               ddlParams.Add("vendorcode", Session["UserName"].ToString());

               GetDropdowns("VendorList");


        
               Month.SelectedValue = DateTime.Now.Month.ToString();
               Year.Text = DateTime.Now.Year.ToString();


               ddlParams.Add("MonthWage", Month.SelectedValue.ToString());
               ddlParams.Add("YearWage", Year.Text.ToString());

               GetDropdowns("Locations_jhar_report", ddlParams);




               GetDropdowns("SiteByLocation", ddlParams);
               GetDropdowns("WorkOrderNoAll_jhar_report", ddlParams);

               VendorCode.DataBind();
               LocationCode.DataBind();
               SiteID.DataBind();
               WorkOrderNo.DataBind();

              // Year.Text = DateTime.Now.Year.ToString();
              // Month.SelectedValue = DateTime.Now.Month.ToString();

               VendorCode.SelectedValue = Session["UserName"].ToString();
               //VendorName.Text = VendorCode.SelectedItem.Text.ToString();
               DataSet ds = new DataSet();
               ds = blobj.GetVendorName(VendorCode.SelectedValue.ToString());

               if (ds.Tables[0].Rows.Count > 0)
                   VendorName.Text = ds.Tables[0].Rows[0]["VendorName"].ToString();
               else
                   VendorName.Text = "";


           }

       }

             <div class="">
          <asp:DropDownList ID="Month" runat="server" CssClass="form-control form-control-sm font-small" OnSelectedIndexChanged="MonthWage_SelectedIndexChanged" AutoPostBack="true" onchange="validateReqInputs(this);"  >
              <asp:ListItem Text="Select" Value="" />
              <asp:ListItem Text="January" Value="1" />
              <asp:ListItem Text="February" Value="2" />
              <asp:ListItem Text="March" Value="3" />
              <asp:ListItem Text="April" Value="4" />
              <asp:ListItem Text="May" Value="5" />
              <asp:ListItem Text="June" Value="6" />
              <asp:ListItem Text="July" Value="7" />
              <asp:ListItem Text="August" Value="8" />
              <asp:ListItem Text="September" Value="9" />
              <asp:ListItem Text="October" Value="10" />
              <asp:ListItem Text="November" Value="11" />
              <asp:ListItem Text="December" Value="12" />
          </asp:DropDownList>
         <asp:RequiredFieldValidator ID="RequiredFieldValidator33" class="invalid-tooltip" ValidationGroup="save" runat="server" ErrorMessage="Required" ControlToValidate="Month" ForeColor="White" Font-Size="X-Small" InitialValue=""></asp:RequiredFieldValidator>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" class="invalid-tooltip" ValidationGroup="BtnSave" runat="server" ErrorMessage="Required" ControlToValidate="Month" ForeColor="White" Font-Size="X-Small" InitialValue=""></asp:RequiredFieldValidator>
      </div>


      on select month my location are not showing pls check and rectifed code
