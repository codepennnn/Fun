protected void Work_Order_No_SelectedIndexChanged(object sender, EventArgs e)
{
    string wo_no = Work_Order_No.SelectedValue;

    if (!string.IsNullOrEmpty(wo_no))
    {
        // Optional: If you truly need only first 10 characters
        // wo_no = wo_no.Substring(0, 10); 

        BL_FormC3DS blobj = new BL_FormC3DS();
        DataSet ds = blobj.GetLicNo(wo_no);

        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
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
        else
        {
            Lic_No.Items.Clear();
            Lic_No.Items.Add(new ListItem("No Lic No Found", ""));
            Lic_No.Enabled = false;
        }
    }
    else
    {
        Lic_No.Items.Clear();
        Lic_No.Items.Add(new ListItem("Please select Work Order", ""));
        Lic_No.Enabled = false;
    }
}
