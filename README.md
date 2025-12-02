protected void HalfYearly_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    // Get selected DataKey values
    var keys = HalfYearly_Records.SelectedDataKey.Values;

    // Extract the values by key names exactly as defined in your DataKeyNames
    string vcode = keys["VCode"].ToString();
    string year = keys["Year"].ToString();
    string period = keys["Period"].ToString();

    // Combine to pass as parameter
    string strKey = $"{vcode},{year},{period}";

    // Call your method
    GetRecord(strKey);

    // Rebind
    HalfYearly_Entry_Records.BindData();
}
