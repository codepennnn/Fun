                <div class="scrollable-grid" style="overflow: auto;height:350px;">
                 
              <asp:GridView ID="C3_Records_Grid" CssClass="grid"  runat="server" 

       GridLines="None" Width="100%" AllowPaging="false"
        ForeColor="#333333" ShowHeaderWhenEmpty="True"
        PageSize="10"
        PagerSettings-Visible="True"
        PagerStyle-HorizontalAlign="Center"
        PagerStyle-Wrap="False"
        HeaderStyle-Font-Size="Smaller"
        RowStyle-Font-Size="Smaller"
        HeaderStyle-HorizontalAlign="Center"
        RowStyle-HorizontalAlign="Center"
        OnPageIndexChanging="C3_Records_Grid_PageIndexChanging">

     <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerSettings Mode="Numeric" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />


  protected void btnSearch_Click(object sender, EventArgs e)
  {
      BL_FormC3DS blobj = new BL_FormC3DS();
      DataSet ds_L1 = new DataSet();

      string searchBy = ddlSearch.SelectedValue;
      string searchText = txtSearch.Text.Trim();

      string licno = string.Empty;
      string wo = string.Empty;

      if (searchBy == "WorkOrderNo")
          wo = searchText;
      else if (searchBy == "LicNo")
          licno = searchText;

      // Get logged in username from session
      string username = Session["Username"]?.ToString();

      // Pass username along with search
      ds_L1 = blobj.GetC3Detail(licno, wo, username);

      if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
      {
          C3_Records_Grid.DataSource = ds_L1.Tables[0];
          C3_Records_Grid.DataBind();
      }
      else
      {
          C3_Records_Grid.DataSource = null;
          C3_Records_Grid.DataBind();
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
      }
  }
  public DataSet GetC3Detail(string LicNo, string wo, string username)
  {
      string strSQL = "select  REFNO,CreatedDt,CreatedBy,V_CODE,V_NAME,FIRM_NAME,PHONE_NO,MOBILE_NO,EMAIL_ID,ADDRESS,WO_NO,DOC_DATE,PERIOD_CONTRACT_FROM,PERIOD_CONTRACT_TO,NATURE_OF_WORK,COMMENCEMENT_DATE_OF_WORK,LOCATION_OF_WORK,DEPARTMENT,PF_CODE,ESI_CODE,NATURE_OF_PAYMENT,AUTHOR_NAME,AUTHOR_EMAIL,AUTHOR_CONTACT_NO,AUTHOR_ADDRESS,Ll_NO,NATURE_OF_LL,LL_VALID_FROM,LL_VALID_UPTO,TOTAL_EMP_LL_OBTAINED_1,LL_REMARKS,TOTAL_WORKMAN,LICENSE_CHOICE,BOCW_CHOICE,STATUS,TOTAL_EMP_LL_OBTAINED_2,WO_VALUE,MONTHLY_VALIDATION_APP,TYPE_OF_PAYMENT,ESI_APP,PRW_APP,WAGES_PF_ESI_DETAIL,Alt_Email,CC_UPDATEDAT,CC_UPDATEDBY,FORMC3_ISSUE_DATE,FORMC3_REFNO,MV_REMARKS,PF_ESI_CODE_REMARKS,REJECTION_REASON,CC_CHOICE,AUTHOR_ADHAR_NUMBER,NO_EMP_BOCW_OBTAINED,LLWM_STRENGTH,C3_CLOSER_DATE,Labour_License_site,Nature,WorkLoc,PE,Deptcode FROM App_Vendor_form_C3_Dtl WHERE 1=1 ";
      Dictionary<string, object> objParam = new Dictionary<string, object>();

     
      if (username.Length == 5)
      {
          strSQL += " AND V_CODE = @V_CODE ";  
          objParam.Add("V_CODE", username);
      }

      if (!string.IsNullOrEmpty(LicNo))
      {
          strSQL += " AND LL_NO = @LicNo ";
          objParam.Add("LicNo", LicNo);
      }

      if (!string.IsNullOrEmpty(wo))
      {
          strSQL += " AND WorkOrderNo = @wo ";
          objParam.Add("wo", wo);
      }

      DataHelper dh = new DataHelper();
      DataSet ds = dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
      return ds;
  }



  //public DataSet GetC3WOrkmanCatDetail(ID)
  //{
  //    string strSQL = "select * from App_Vendor_FormC3_WorkManCat  WHERE Master_ID = @ID";
  //    Dictionary<string, object> objParam = new Dictionary<string, object>();
  //    objParam.Add("ID", ID);
  //    DataHelper dh = new DataHelper();
  //    DataSet ds = new DataSet();
  //    ds = dh.GetDataset(strSQL, "App_Vendor_FormC3_WorkManCat", objParam);
  //    return ds;
  //}
i want another gird that is connected with  firstgrid table id to second grid table master id

and also visible false my grid before search after search it is visible
    </asp:GridView>

                </div>
