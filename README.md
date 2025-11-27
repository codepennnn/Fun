   <div class="form-inline row">

       <div class="form-group col-md-4">
           <label for="lblYear" class="m-0 mr-0 p-0 col-form-label-sm col-sm-1 font-weight-bold fs-6">Year:</label>
           <asp:DropDownList ID="Year" runat="server" CssClass="form-control form-control-sm col-sm-6">
               <asp:ListItem Value="2024">2024</asp:ListItem>
               <asp:ListItem Value="2025">2025</asp:ListItem>
               <asp:ListItem Value="2026">2026</asp:ListItem>
               <asp:ListItem Value="2027">2027</asp:ListItem>
               <asp:ListItem Value="2028">2028</asp:ListItem>
               <asp:ListItem Value="2029">2029</asp:ListItem>
               <asp:ListItem Value="2030">2030</asp:ListItem>
           </asp:DropDownList>
       </div>

       <div class="form-group col-md-4">
           <label for="lblMonth" class="m-0 mr-0 p-0 col-form-label-sm col-sm-1 font-weight-bold fs-6">Month:</label>
           <asp:DropDownList ID="SearchPeriod" runat="server"
               CssClass="form-control form-control-sm col-sm-6">

               <asp:ListItem Value="Jan-June">Jan-June</asp:ListItem>
               <asp:ListItem Value="July-Dec">July-Dec</asp:ListItem>

           </asp:DropDownList>
       </div>

       <div class="form-group col-md-2">
           <asp:Button ID="Search" runat="server" Text="View" Style="margin-top: 4px;" CssClass="btn btn-sm btn-primary" OnClick="Search_Click" />
       </div>

   </div>


      protected void Search_Click(object sender, EventArgs e)
   {
       btnSave.Visible = true;
       BL_Half_Yearly blobj = new BL_Half_Yearly();
       DataSet ds = new DataSet();
       


       string strKey = Session["Username"].ToString() + "," + Year.SelectedValue + "," + SearchPeriod.SelectedValue;
       GetRecord(strKey);
       if(PageRecordDataSet.Tables[0].Rows.Count>0)
       { 
           HalfYearly_Records.DataBind();            //PageRecordDataSet.Merge(ds);
       }
       else
       {
           int year = Convert.ToInt32(Year.SelectedValue);
           string month = SearchPeriod.SelectedValue.ToString();
           string fromdt = "";
           string todt = "";
           if (month == "Jan-June")
           {
               fromdt = new DateTime(year, 1, 1).ToString("yyyy-MM-dd");
               todt = new DateTime(year, 6, 30).ToString("yyyy-MM-dd");
           }
           else
           {
               fromdt = new DateTime(year, 7, 1).ToString("yyyy-MM-dd");
               todt = new DateTime(year, 12, 31).ToString("yyyy-MM-dd");
           }
           string vcode = Session["UserName"].ToString();

           ds = blobj.GetData(vcode, fromdt, todt);

          
           PageRecordDataSet.Merge(ds);
           HalfYearly_Records.BindData();
       }


       
   }

  
  
  
  <cc1:DetailsContainer ID="HalfYearly_Records" runat="server" AutoGenerateColumns="False" AllowPaging="False" CellPadding="0" GridLines="Both" DataMember="App_Half_Yearly_Details"
      DataKeyNames="ID" DataSource="<%# PageRecordDataSet %>" ForeColor="#333333" ShowHeaderWhenEmpty="False"
      OnRowDataBound="PF_ESI_Records_RowDataBound" PagerSettings-Visible="False" PagerStyle-HorizontalAlign="Center" RowStyle-ForeColor="Black"
      PagerStyle-Wrap="False" HeaderStyle-Font-Size="13px" RowStyle-Font-Size="11px" class="border " Style="margin-top: 12px;" CssClass="styled-grid">
      <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
      <Columns>

          <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="False">
              <ItemTemplate>
                  <asp:Label ID="ID" runat="server"></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Sl. No.">
              <ItemTemplate>&emsp;<%# Container.DataItemIndex + 1 + "."%></ItemTemplate>
              <ItemStyle Width="4%" />
          </asp:TemplateField>
          <asp:BoundField DataField="Name_Address_Of_Contractor" HeaderText="Name and Address Of Contractor" SortExpression="Name_Address_Of_Contractor">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>
          <asp:TemplateField HeaderText="Name and Address Of Establishment" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:TextBox ID="Name_Address_Of_Establishment" runat="server" CssClass="form-control form-control-sm font-small">
                  </asp:TextBox>

              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Principal Employer" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:DropDownList ID="Name_and_Address_Of_PrincipalEmp" runat="server" CssClass="form-control form-control-sm font-small">
                      <asp:ListItem></asp:ListItem>
                      <asp:ListItem Value="Tata Steel Limited">Tata Steel Limited</asp:ListItem>
                      <asp:ListItem Value="Tata Steel UISL">Tata Steel UISL</asp:ListItem>
                      <asp:ListItem Value="JUIDCO,Ranchi">JUIDCO,Ranchi</asp:ListItem>
                      <asp:ListItem Value="Manipal Tata Medical College">Manipal Tata Medical College</asp:ListItem>
                      <asp:ListItem Value="Tata Steel Foundation">Tata Steel Foundation</asp:ListItem>
                      <asp:ListItem Value="NINL">NINL</asp:ListItem>
                      <asp:ListItem Value="Tata Steel FAP, Jajpur">Tata Steel FAP, Jajpur</asp:ListItem>
                      <asp:ListItem Value="TRF">TRF</asp:ListItem>
                      <asp:ListItem Value="Tata Pigments Limited">Tata Pigments Limited</asp:ListItem>
                      <asp:ListItem Value="Tata Steel IBMD">Tata Steel IBMD</asp:ListItem>
                      <asp:ListItem Value="Others">Others</asp:ListItem>
                  </asp:DropDownList>

              </ItemTemplate>
          </asp:TemplateField>



          <asp:BoundField DataField="LabourLicNo" HeaderText="Lic No" SortExpression="LabourLicNo">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>

          <asp:BoundField DataField="Duration_Of_Contract" HeaderText="Duration Of Contract" SortExpression="Duration_Of_Contract">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>

          <%-- testing--%>

          <asp:TemplateField HeaderText="State" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:TextBox ID="State" runat="server" CssClass="form-control form-control-sm font-small">
                  </asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>


          <asp:TemplateField HeaderText="Status" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:TextBox ID="Status" runat="server" CssClass="form-control form-control-sm font-small">
                  </asp:TextBox>

              </ItemTemplate>
          </asp:TemplateField>


          <asp:TemplateField HeaderText="Welfare Canteen" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:TextBox ID="Welfare_Canteen" runat="server" CssClass="form-control form-control-sm font-small">
                  </asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>

          <asp:TemplateField HeaderText="Weekly Holiday" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:TextBox ID="Weekly_Holiday" runat="server" CssClass="form-control form-control-sm font-small">
                  </asp:TextBox>

              </ItemTemplate>
          </asp:TemplateField>


          <asp:BoundField DataField="WorkOrderNo" HeaderText="WorkOrderNo" SortExpression="WorkOrderNo">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>

          <asp:BoundField DataField="sex_M" HeaderText="sex_M" SortExpression="sex_M">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>

          <asp:BoundField DataField="sex_F" HeaderText="sex_F" SortExpression="sex_F">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>


          <asp:BoundField DataField="TotalMandays_Male" HeaderText="TotalMandays_Male" SortExpression="TotalMandays_Male">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>


          <asp:BoundField DataField="TotalMandays_Female" HeaderText="TotalMandays_Female" SortExpression="TotalMandays_Female">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>


          <asp:BoundField DataField="Male_Deduction" HeaderText="Male_Deduction" SortExpression="Male_Deduction">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>


          <asp:BoundField DataField="Female_Deduction" HeaderText="Female_Deduction" SortExpression="Female_Deduction">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>


          <asp:BoundField DataField="Male_Gross" HeaderText="Male_Gross" SortExpression="Male_Gross">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>


          <asp:BoundField DataField="Female_Gross" HeaderText="Female_Gross" SortExpression="Female_Gross">
              <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>





          <asp:TemplateField HeaderText="Canteen" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:DropDownList ID="Canteen" runat="server" CssClass="form-control form-control-sm font-small">
                      <asp:ListItem></asp:ListItem>
                      <asp:ListItem Value="YES">YES</asp:ListItem>
                      <asp:ListItem Value="NA">NA</asp:ListItem>

                  </asp:DropDownList>

              </ItemTemplate>
          </asp:TemplateField>


          <asp:TemplateField HeaderText="Rest Rooms" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:DropDownList ID="Rest_Rooms" runat="server" CssClass="form-control form-control-sm font-small">
                      <asp:ListItem></asp:ListItem>
                      <asp:ListItem Value="YES">YES</asp:ListItem>
                      <asp:ListItem Value="NA">NA</asp:ListItem>

                  </asp:DropDownList>

              </ItemTemplate>
          </asp:TemplateField>


          <asp:TemplateField HeaderText="Drinking Water" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:DropDownList ID="Drinking_Water" runat="server" CssClass="form-control form-control-sm font-small">
                      <asp:ListItem></asp:ListItem>
                      <asp:ListItem Value="YES">YES</asp:ListItem>
                    

                  </asp:DropDownList>

              </ItemTemplate>
          </asp:TemplateField>


          <asp:TemplateField HeaderText="Creches" HeaderStyle-ForeColor="White">
              <ItemTemplate>
                  <asp:DropDownList ID="Creches" runat="server" CssClass="form-control form-control-sm font-small">
                      <asp:ListItem></asp:ListItem>
                      <asp:ListItem Value="YES">YES</asp:ListItem>
                      <asp:ListItem Value="NA">NA</asp:ListItem>

                  </asp:DropDownList>

              </ItemTemplate>
          </asp:TemplateField>


            <asp:TemplateField HeaderText="First Aid" HeaderStyle-ForeColor="White">
        <ItemTemplate>
            <asp:DropDownList ID="First_Aid" runat="server" CssClass="form-control form-control-sm font-small">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="YES">YES</asp:ListItem>
               

            </asp:DropDownList>

        </ItemTemplate>
    </asp:TemplateField>












      </Columns>
      <EditRowStyle BackColor="#999999" />
      <FooterStyle BackColor="#003570" ForeColor="White" Font-Bold="True" />
      <HeaderStyle BackColor="#003570" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
      <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
      <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
      <SortedAscendingCellStyle BackColor="#E9E7E2" />
      <SortedAscendingHeaderStyle BackColor="#506C8C" />





            protected void btnSave_Click(object sender, EventArgs e)
      {
          HalfYearly_Records.UnbindData();

          PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["VCode"] = Session["Username"].ToString();
          PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Year"] = Year.SelectedValue;
          PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Period"] = SearchPeriod.SelectedValue;
         

          string vc = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["VCode"].ToString();
          string year = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Year"].ToString();
          string Period = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Period"].ToString();



          BL_Half_Yearly blobj = new BL_Half_Yearly();
          DataSet dsExist = blobj.chkExist(vc, year, Period);
          bool isExist = dsExist != null && dsExist.Tables[0].Rows.Count > 0;

          if(isExist)
          {
              string oldRef = dsExist.Tables[0].Rows[0]["RefNo"].ToString();
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["RefNo"] = oldRef;
              PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ResubmitedOn"] = System.DateTime.Now;
              //PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].AcceptChanges();

          }
          else
          { 
              DataSet ds = new DataSet();
              ds = blobj.GetDelete(vc, year, Period);

              if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0].RowState == DataRowState.Modified)
              {

                  for (int i = 0; i < PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows.Count; i++)
                  {
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["VCode"] = Session["Username"].ToString();
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Year"] = Year.SelectedValue;
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["Period"] = SearchPeriod.SelectedValue;
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].AcceptChanges();
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i].SetAdded();
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedBy"] = Session["UserName"].ToString();
                      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[i]["CreatedOn"] = System.DateTime.Now;

                  }
                  

              }
          }


          bool result = Save();

          if (result)
          {
              string Ref_No = blobj.Get_Ref_No(PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ID"].ToString());




             System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Your Half Yearly Ref No. is: " + Ref_No + "');", true);

             PageRecordDataSet.Clear();
             HalfYearly_Records.BindData();
             btnSave.Visible = false;
             MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");



          }
          else
          {
              MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Error While Saving !");
          }
      }


        public DataSet GetData(string vcode, string fromdt, string todt)
  {
      Dictionary<string, object> objParam = new Dictionary<string, object>();
      DataHelper dh = new DataHelper();
      // string strSQL = "SELECT newid() as ID,LicNo as LabourLicNo,FromDate,ToDate FROM App_LabourLicenseSubmission  WHERE  Vcode = @Vcode";

      //string strSQL = " SELECT newid() as ID,LicNo as LabourLicNo,FromDate,ToDate FROM App_LabourLicenseSubmission  WHERE  " +
      //" FromDate < @FromDate AND ToDate >= @ToDate and WorkLocation in ('Jamshedpur', 'Seraikela') and Vcode = @Vcode";

      //string strSQL = "SELECT newid() as ID,LicNo as LabourLicNo,FromDate,ToDate,convert(varchar(10),DATEDIFF(DAY, convert(datetime,FromDate,103), " +
      //    "convert(datetime,ToDate,103))) AS Duration_Of_Contract,(select concat (V_NAME,', ',ADDRESS) from App_Vendor_Reg R where R.V_CODE=Vcode) as Name_Address_Of_Contractor" +
      //    " FROM App_LabourLicenseSubmission  WHERE   FromDate < @FromDate AND ToDate >= @ToDate and VCode=@Vcode and WorkLocation in('Jamshedpur','Saraiekela')";



      string strSQL = @"
                  SELECT NEWID() AS ID,l.LicNo AS LabourLicNo,l.FromDate,l.ToDate,
                          CONVERT(varchar(10),
                          DATEDIFF(DAY, CONVERT(datetime, l.FromDate, 103), CONVERT(datetime, l.ToDate, 103))) AS Duration_Of_Contract,
                      (SELECT CONCAT(R.V_NAME, ', ', R.ADDRESS) FROM App_Vendor_Reg AS R WHERE R.V_CODE = l.VCode
                      ) AS Name_Address_Of_Contractor,
                      c3.wo_no As WorkOrderNo,

                   
                      (SELECT COUNT(DISTINCT w.AadharNo) FROM App_Wagesdetailsjharkhand AS w
                          INNER JOIN App_EmployeeMaster AS em
                              ON em.AadharCard = w.AadharNo AND em.Sex = 'M'
                          WHERE w.workorderno = c3.wo_no
                            AND w.vendorcode = @Vcode
                            AND w.monthwage IN (1,2,3,4,5,6)
                            AND w.yearwage = '2025'
                      ) AS sex_M,

                      (SELECT COUNT(DISTINCT w.AadharNo) FROM App_Wagesdetailsjharkhand AS w
                          INNER JOIN App_EmployeeMaster AS em
                              ON em.AadharCard = w.AadharNo AND em.Sex = 'F'
                          WHERE w.workorderno = c3.wo_no
                            AND w.vendorcode = @Vcode
                            AND w.monthwage IN (1,2,3,4,5,6)
                            AND w.yearwage = '2025'
                      ) AS sex_F,

        
                      (SELECT ISNULL(SUM(tab.TotalMandays), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
                              FROM app_wagesdetailsjharkhand AS w
                              INNER JOIN app_employeemaster AS em
                                  ON em.aadharcard = w.aadharno AND em.sex = 'M'
                              WHERE w.workorderno = c3.wo_no
                                AND w.vendorcode = @Vcode
                                AND w.monthwage IN (1,2,3,4,5,6)
                                AND w.yearwage = '2025'
                              GROUP BY w.AadharNo
                          ) AS tab
                      ) AS TotalMandays_Male,

                      (SELECT ISNULL(SUM(tab.TotalMandays), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
                              FROM app_wagesdetailsjharkhand AS w
                              INNER JOIN app_employeemaster AS em
                                  ON em.aadharcard = w.aadharno AND em.sex = 'F'
                              WHERE w.workorderno = c3.wo_no
                                AND w.vendorcode = @Vcode
                                AND w.monthwage IN (1,2,3,4,5,6)
                                AND w.yearwage = '2025'
                              GROUP BY w.AadharNo
                          ) AS tab
                      ) AS TotalMandays_Female,

                 
                      (SELECT ISNULL(SUM(tab.Male_Deduction), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Male_Deduction
                              FROM app_wagesdetailsjharkhand AS w
                              INNER JOIN app_employeemaster AS em
                                  ON em.aadharcard = w.aadharno AND em.sex = 'M'
                              WHERE w.workorderno = c3.wo_no
                                AND w.vendorcode = @Vcode
                                AND w.monthwage IN (1,2,3,4,5,6)
                                AND w.yearwage = '2025'
                              GROUP BY w.AadharNo
                          ) AS tab
                      ) AS Male_Deduction,

                      (SELECT ISNULL(SUM(tab.Female_Deduction), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Female_Deduction
                              FROM app_wagesdetailsjharkhand AS w
                              INNER JOIN app_employeemaster AS em
                                  ON em.aadharcard = w.aadharno AND em.sex = 'F'
                              WHERE w.workorderno = c3.wo_no
                                AND w.vendorcode = @Vcode
                                AND w.monthwage IN (1,2,3,4,5,6)
                                AND w.yearwage = '2025'
                              GROUP BY w.AadharNo
                          ) AS tab
                      ) AS Female_Deduction,

                    
                      (SELECT ISNULL(SUM(tab.Male_Gross), 0) FROM ( SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Male_Gross
                              FROM app_wagesdetailsjharkhand AS w
                              INNER JOIN app_employeemaster AS em
                                  ON em.aadharcard = w.aadharno AND em.sex = 'M'
                              WHERE w.workorderno = c3.wo_no
                                AND w.vendorcode = @Vcode
                                AND w.monthwage IN (1,2,3,4,5,6)
                                AND w.yearwage = '2025'
                              GROUP BY w.AadharNo
                          ) AS tab
                      ) AS Male_Gross,

                      (SELECT ISNULL(SUM(tab.Female_Gross), 0) FROM (SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Female_Gross
                              FROM app_wagesdetailsjharkhand AS w
                              INNER JOIN app_employeemaster AS em
                                  ON em.aadharcard = w.aadharno AND em.sex = 'F'
                              WHERE w.workorderno = c3.wo_no
                                AND w.vendorcode = @Vcode
                                AND w.monthwage IN (1,2,3,4,5,6)
                                AND w.yearwage = '2025'
                              GROUP BY w.AadharNo
                          ) AS tab
                      ) AS Female_Gross

                  FROM App_LabourLicenseSubmission AS l
                  LEFT JOIN App_vendor_form_c3_dtl AS c3
                      ON c3.ll_no = l.LicNo
                  WHERE
                      c3.status = 'Approved'
                      AND l.FromDate < @ToDate
                      AND l.ToDate >= @FromDate
                      AND l.VCode = @Vcode
                      AND l.WorkLocation IN ('Jamshedpur', 'Saraiekela');";






      objParam.Add("Vcode", vcode); 
      objParam.Add("FromDate", todt);
      objParam.Add("ToDate", fromdt);
      DataSet ds = dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
      return ds;
  }
        
      <SortedDescendingCellStyle BackColor="#FFFDF8" />
      <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
  </cc1:DetailsContainer>
