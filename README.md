if (dropD != null)
{
    Lic_No.Items.Clear();
    Lic_No.Items.Add(new ListItem("Please select", ""));

    foreach (DataRow row in ds.Tables[0].Rows)
    {
        string lic = row["Ll_NO"].ToString();
        Lic_No.Items.Add(new ListItem(lic, lic));
    }
    
    Lic_No.SelectedIndex = 0;
    Lic_No.Enabled = true;
}
