                             <asp:GridView ID="Grid" runat="server" Style="text-align: center; width: 3000px; height: 100px;" AutoGenerateColumns="False"
   AllowPaging="false" CellPadding="0" GridLines="Both"  OnRowDataBound="Grid_RowDataBound"
   ForeColor="#333333" ShowHeaderWhenEmpty="True" SortedAscendingCellStyle-BorderColor="Black" SortedAscendingCellStyle-BorderWidth="1px" SortedAscendingCellStyle-BorderStyle="Solid"
   PageSize="100" PagerSettings-Visible="false" PagerStyle-HorizontalAlign="Center" RowStyle-Height="30px"
   PagerStyle-Wrap="True" HeaderStyle-Font-Size="small" RowStyle-Font-Size="small" CssClass="freezeColumn"
   HeaderStyle-HorizontalAlign="Center" RowStyle-ForeColor="Black" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
   <AlternatingRowStyle BackColor="White" ForeColor="#284775" />


   <Columns>
       <asp:TemplateField HeaderText="Sl.No." SortExpression="Sl_No"
           HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
           <ItemTemplate><%# Container.DataItemIndex + 1 + "."%></ItemTemplate>
       </asp:TemplateField>

  

       <asp:TemplateField HeaderText="ID" Visible="false">
           <ItemTemplate><asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Year" HeaderStyle-Width="50px">
           <ItemTemplate><asp:Label ID="lblYear" runat="server" Text='<%# Eval("Year") %>' /></ItemTemplate>
       </asp:TemplateField>
                                    
       <asp:TemplateField HeaderText="Vendor Code" HeaderStyle-Width="50px">
           <ItemTemplate><asp:Label ID="lblVcode" runat="server" Text='<%# Eval("Vcode") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Aadhar No.">
           <ItemTemplate><asp:Label ID="lblAadharNo" runat="server" Text='<%# Eval("AadharNo") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="WorkMan Sl.No." HeaderStyle-Width="50px">
           <ItemTemplate><asp:Label ID="lblWorkManSlno" runat="server" Text='<%# Eval("WorkManSlno") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Workorder No.">
           <ItemTemplate><asp:Label ID="lblWorkorderNo" runat="server" Text='<%# Eval("WorkorderNo") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="WorkMan Category">
           <ItemTemplate><asp:Label ID="lblWorkManCategory" runat="server" Text='<%# Eval("WorkManCategory") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="WorkMan Name">
           <ItemTemplate><asp:Label ID="lblWorkManName" runat="server" Text='<%# Eval("WorkManName") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="No. of days worked">
           <ItemTemplate><asp:Label ID="lblTotaldaysWorked" runat="server" Text='<%# Eval("TotaldaysWorked") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Total Wages (Basic + DA)"> 
           <ItemTemplate><asp:Label ID="lblTotalWages" runat="server" Text='<%# Eval("TotalWages") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Puja Bonus of other quota many Bonus Paid during the accounting year">
           <ItemTemplate><asp:Label ID="lblPuja_Bonus" runat="server" Text='<%# Eval("Puja_Bonus") %>' /></ItemTemplate>
       </asp:TemplateField>
                                      
       <asp:TemplateField HeaderText="Interim Bonus or Bonus paid in advance">
           <ItemTemplate><asp:Label ID="lblInterim_Bonus" runat="server" Text='<%# Eval("Interim_Bonus") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Deduction on a/c of financial if any caused by misconduct of the employee">
           <ItemTemplate><asp:Label ID="lblDeduction_misconduct_emp" runat="server" Text='<%# Eval("Deduction_misconduct_emp") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Total sum of Deduction">
           <ItemTemplate><asp:Label ID="lblTotal_deduction" runat="server" Text='<%# Eval("Total_deduction") %>' /></ItemTemplate>
       </asp:TemplateField>

       <asp:TemplateField HeaderText="Net Bonus Payable Amount">
           <ItemTemplate><asp:Label ID="lblBonusPayableAmount" runat="server" Text='<%# Eval("BonusPayableAmount") %>' /></ItemTemplate>
       </asp:TemplateField>

       <%--<asp:TemplateField HeaderText="Net Bonus Paid in bank">
           <ItemTemplate><asp:Label ID="lblBonus_Paid_Amount" runat="server" Text='<%# Eval("Bonus_Paid_Amount") %>' /></ItemTemplate>
       </asp:TemplateField>--%>

   <asp:TemplateField HeaderText="Net Bonus Paid in bank">
    <ItemTemplate>
        <asp:TextBox ID="Bonus_Paid_Amount" Text='<%# Eval("Bonus_Paid_Amount") %>' runat="server" OnChange="Calculation_UnpaidAmount()" ></asp:TextBox>
    </ItemTemplate>
</asp:TemplateField>

  <%--     <asp:TemplateField HeaderText="Bonus UnPaid Amount">
           <ItemTemplate><asp:Label ID="lblBonus_UnPaid_Amount" runat="server" Text='<%# Eval("Bonus_UnPaid_Amount") %>' /></ItemTemplate>
       </asp:TemplateField>--%>

        <asp:TemplateField HeaderText="Bonus UnPaid Amount">
             <ItemTemplate>
                 <asp:TextBox ID="Bonus_UnPaid_Amount" Text='<%# Eval("Bonus_UnPaid_Amount") %>' runat="server" OnChange="Calculation_UnpaidAmount()" ></asp:TextBox>
             </ItemTemplate>
         </asp:TemplateField>

      <%-- <asp:TemplateField HeaderText="Bank Statement Slno">
           <ItemTemplate><asp:Label ID="lblBankStatementSlno" runat="server" Text='<%# Eval("BankStatementSlno") %>' /></ItemTemplate>
       </asp:TemplateField>--%>

      <asp:TemplateField HeaderText="Bank Statement Sl.No.">
           <ItemTemplate>
               <asp:TextBox ID="BankStatementSlno" Text='<%# Eval("BankStatementSlno") %>' runat="server"></asp:TextBox>
           </ItemTemplate>
       </asp:TemplateField>



  </Columns>


  <EditRowStyle BackColor="#999999" />
  <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
  <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
  <PagerSettings Mode="Numeric" />
  <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
  <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
  <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
  <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
  <SortedAscendingCellStyle BackColor="#E9E7E2" />
  <SortedAscendingHeaderStyle BackColor="#506C8C" />
  <SortedDescendingCellStyle BackColor="#FFFDF8" />
  <SortedDescendingHeaderStyle BackColor="#6F8DAE" />


</asp:GridView>









          
                             
                      </div>
              <%--  31-07-2025--%>
                  <div class="row m-0 mt-1" style="float:right">


                 <asp:Button ID="btnDwnld" runat="server" Text="Download" OnClick="btnDwnld_Click" CssClass="btn btn-sm btn-info" Style="width: 100px;border-radius: 31px;background-color: darkgreen;height: 27px;padding: 0px;"/>&nbsp
             </div>

                 protected void btnDwnld_Click(object sender, EventArgs e)
    {

        DataSet ds = new DataSet();
        ds.Merge(PageRecordDataSet.Tables["App_Bonus_Comp_Details"]);
        if (ds.Tables[0].Rows.Count > 0)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("BonusData");
                DataTable dt = ds.Tables[0];
                for (int i = 2; i < dt.Columns.Count; i++)
                {
                    ws.Cell(1, i - 1).Value = dt.Columns[i].ColumnName;
                }

                for (int row = 0; row < dt.Rows.Count; row++)
                {

                    for (int col = 2; col < dt.Columns.Count; col++)
                    {
                        ws.Cell(row + 2, col - 1).Value = dt.Rows[row][col].ToString();
                    }



                }
                for (int col = 2; col <= dt.Columns.Count; col++)
                {
                    ws.Column(col - 1).AdjustToContents();
                }



                using (MemoryStream ms = new MemoryStream())
                {
                    wb.SaveAs(ms);
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("Content-Disposition", "attachment; filename=Bonus_Compliance_Details.xlsx");
                    Response.BinaryWrite(ms.ToArray());
                    Response.Flush();
                    Response.End();
                }
            }

        }
    }

my code wokring very well for dwnlod excel but i want to dwnlod it thorugh grid ui screen not pagerecord dataset
