   protected void Search_Click(object sender, EventArgs e)
   {
   
       BL_Half_Yearly blobj = new BL_Half_Yearly();
       DataSet ds = new DataSet();
       ReportDataSource rds = new ReportDataSource();



       int year = Convert.ToInt32(Year.SelectedValue);
           string month = SearchPeriod.SelectedValue.ToString();
           string fromdt = "";
           string todt = "";
         
           string vcode = Session["UserName"].ToString();
           string Period = SearchPeriod.SelectedValue;

       if (Year.SelectedIndex == 0 || SearchPeriod.SelectedIndex == 0)
       {

           ReportViewer1.Visible = false;
           MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Please select Month & Year !!!");

         
       }
           else
           {
               ds = blobj.GetData(vcode, fromdt, todt, Period, year);


               PageRecordDataSet.Merge(ds);


               rds.Name = "DataSet1";
               rds.Value = ds.Tables[0];
               ReportViewer1.Visible = true;
               ReportViewer1.LocalReport.ReportPath = "App\\Report\\Half_Yearly_Report.rdlc";
               ReportViewer1.LocalReport.DataSources.Clear();
               ReportViewer1.LocalReport.DataSources.Add(rds);
               ReportViewer1.LocalReport.Refresh();

           }

   }


     <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px; overflow: auto">
      <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: darkslategray"><b>Search</b></legend>

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


      <div class="form-inline row">

               <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
               Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
               WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"  Width ="100%">
               <LocalReport ReportPath="App\Report\Half_Yearly_Report.rdlc">
               </LocalReport>
           </rsweb:ReportViewer>
       

      </div>




   
  </fieldset>


  public DataSet GetReport(string vcode, string fromdt, string todt, string Period, int year)
  {
      string strSQL = " select * from App_Half_Yearly_Details where Vcode=@Vcode and Year=@year and Period=@Period ";
      Dictionary<string, object> objParam = new Dictionary<string, object>();
      DataHelper dh = new DataHelper();
      objParam.Add("Vcode", vcode);
      objParam.Add("FromDate", todt);
      objParam.Add("ToDate", fromdt);
      objParam.Add("Period", Period);
      objParam.Add("year", year);
      DataSet ds = dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
      return ds;
  }



  is my code approach is correct
