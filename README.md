    protected void Work_Order_No_SelectedIndexChanged(object sender, EventArgs e)
    {
        string wo_no = Work_Order_No.SelectedValue.Substring(0, 10);

        BL_FormC3DS blobj = new BL_FormC3DS();
        DataSet ds = new DataSet();
        ds = blobj.GetLicNo(wo_no);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string lic = string.Empty;
            DropDownList dropD = Lic_No;
         
            if (dropD != null)
            {
                Lic_No.Items.Clear();
                Lic_No.Items.Add(new ListItem("Please select", ""));

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    string licc = row["Ll_NO"].ToString();
                    Lic_No.Items.Add(new ListItem(licc, licc));
                }

                Lic_No.SelectedIndex = 0;
                Lic_No.Enabled = true;
            }

        }


                  <div class="form-group col-lg-2 col-md-4 mb-1">
              <div class="">
                  <label class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6">Lic No :<span class="text-danger">*</span></label>
              </div>
              <div class="">

                  <asp:DropDownList ID="Lic_No" runat="server" CssClass="form-control form-control-sm" Font-Size="Small">
                  </asp:DropDownList>

              </div>
          </div>
