   <div class="container-fluid mb-5 animate__animated animate__fadeInUp">
  <div class="table-responsive">
      <table class="table table-bordered table-hover shadow-sm align-middle rounded">
          <thead class="table-dark text-center">
              <tr>
                  <th>Sl No</th>
                  <th>Employee Name</th>
                  <th>Employee Code</th>
                  <th>Settlement Date</th>
                  <th>Status</th>
                 
              </tr>
          </thead>
          <tbody class="text-center">
              <tr>
                  <td>1</td>
                  <td>John Doe</td>
                  <td>EMP001</td>
                  <td>2025-04-05</td>
                  <td><span class="badge bg-success">Completed</span></td>
               
              </tr>
              <tr>
                  <td>2</td>
                  <td>Jane Smith</td>
                  <td>EMP002</td>
                  <td>2025-04-07</td>
                  <td><span class="badge bg-warning text-dark">Pending</span></td>
                
              </tr>
              <!-- Add more rows as needed -->
          </tbody>
      </table>
  </div>
 </div>
  
  
  
  
  
  
  
  
  
  
  
       <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px; overflow: auto">
           <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Previously made entries</b></legend>
          <%-- <div class="w-100 border" style="overflow:auto;height:200px;">--%>

                <div style="overflow:scroll;height:200px" id="FNF_StartPage_Grid" runat="server">
               <cc1:DetailsContainer ID="FNF_StartPage_Records" runat="server" AutoGenerateColumns="False"
                   AllowPaging="false" CellPadding="4" GridLines="None" Width="100%" DataMember="App_FNF_Compliance"
                   DataKeyNames="V_Code" DataSource="<%# PageRecordsDataSet %>"
                   ForeColor="#333333" ShowHeaderWhenEmpty="True"
                   
                   PageSize="10" PagerSettings-Visible="True" PagerStyle-HorizontalAlign="Center"
                   PagerStyle-Wrap="False" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller">
                   <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                   <Columns>
                     

                     

                       <asp:BoundField DataField="V_Code" HeaderText="Vendor Code" HeaderStyle-Width="100px"
                           SortExpression="V_Code" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField>

                         <asp:BoundField DataField="V_NAME" HeaderText="Vendor Name" HeaderStyle-Width="100px"
                           SortExpression="V_NAME" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField>

                      
                       <asp:BoundField DataField="WO_NO" HeaderText="Workorder No." HeaderStyle-Width="110px"
                           SortExpression="WO_NO" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField> 

                       

                       <asp:BoundField DataField="L1_CreatedBy" HeaderText="L1 CreatedBy" HeaderStyle-Width="100px"
                           SortExpression="L1_CreatedBy" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField> 

                       <asp:BoundField DataField="L1_CreatedOn" HeaderText="L1 CreatedOn" HeaderStyle-Width="100px"
                           SortExpression="L1_CreatedOn" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField> 

                       <asp:BoundField DataField="L2_CreatedOn" HeaderText="L2 CreatedOn" HeaderStyle-Width="100px"
                           SortExpression="L2_CreatedOn" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField> 

                       <asp:BoundField DataField="L2_CreatedBy" HeaderText="L2 CreatedBy" HeaderStyle-Width="100px"
                           SortExpression="L2_CreatedBy" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />

                       </asp:BoundField> 

                       <asp:BoundField DataField="RefNo" HeaderText="Reference No."
                           SortExpression="RefNo" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />

                       </asp:BoundField> 


                       <asp:BoundField DataField="Status" HeaderText="Status" 
                           SortExpression="Status" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField>     

                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                           SortExpression="Remarks" HeaderStyle-HorizontalAlign="Left"
                           ItemStyle-HorizontalAlign="Left">
                           <HeaderStyle HorizontalAlign="Left" />
                           <ItemStyle HorizontalAlign="Left" />
                       </asp:BoundField>

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
               </cc1:DetailsContainer>

           </div>
       </fieldset>

    convert upper code to lower code in asp .net
