    <div class="card-body pt-1">
        <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
                <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Records</b></legend>
                     <div class="form-inline row">
                    <!-- Search By -->
                    <div class="form-group col-md-4 mb-1">
                        <label for="ddlSearch" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Search With:</label>
                        <asp:DropDownList ID="Month" runat="server" CssClass="form-control form-control-sm col-sm-5" required="">
                            <asp:ListItem Value="">--Select Month--</asp:ListItem>
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
                    </div>

                       <div class="form-group col-md-4 mb-1">
                         <label for="ddlSearch" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Search With:</label>
                         <asp:DropDownList ID="Year" runat="server" CssClass="form-control form-control-sm col-sm-5" required="">
                             <asp:ListItem Value="">--Select Year--</asp:ListItem>
                            <asp:ListItem Value="2024" Text="2024" />
                              <asp:ListItem Value="2025" Text="2025" />
                              <asp:ListItem Value="2026" Text="2026" />
                              <asp:ListItem Value="2027" Text="2027" />
                              <asp:ListItem Value="2028" Text="2028" />
                              <asp:ListItem Value="2029" Text="2029" />
                              <asp:ListItem Value="2030" Text="2030" />
                         </asp:DropDownList>
                     </div>

                    <!-- Search Button -->
                    <div class="form-group col-md-3 mb-1">
                        <asp:Button ID="btnSearch" runat="server" Text="Search"
                            OnClick="btnSearch_Click"
                            CssClass="btn btn-sm btn-info" ValidationGroup="search" />
                    </div>
                </div>

        </fieldset>
      


    </div>
  

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        BL_Compliance_MIS blobj = new BL_Compliance_MIS();
        DataSet ds_L1 = new DataSet();

        string MonthSearch = Month.SelectedValue;
        string YearSearch = Year.SelectedValue;
                 
     
        ds_L1 = blobj.GetContractorWorker(MonthSearch, YearSearch);

        if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
        {
            if (.Rows.Count == 0)
            {
                return;
            }
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Mis_Summary_Dept_Report.csv");
            Response.ContentType = "text/csv";
            using (StringWriter sw = new StringWriter())
            {

                sw.Write("SL. No,");
                for (int i = 0; i < .HeaderRow.Cells.Count; i++)
                {

                    if (i == 0 || i == 1 || i == 2) continue;

                    sw.Write(CleanCellData(.HeaderRow.Cells[i].Text) + ",");


                }
                sw.Write(sw.NewLine);
                int rowIndex = 1;
                foreach (GridViewRow row in .Rows)
                {
                    sw.Write(rowIndex + ","); // Write SL. No
                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                        if (i == 0 || i == 1 || i == 2) continue;
                        //{
                        sw.Write(CleanCellData(row.Cells[i].Text) + ",");
                        //}
                    }
                    sw.Write(sw.NewLine);
                    rowIndex++;
                }
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();


            }

        }
        else
        {
           
            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
        }



    }

when search click it should be download excel csv file
