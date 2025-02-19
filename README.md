

private void LoadPageRecordDataSet()
{
    string query = "SELECT * FROM App_WagesDetailsJharkhand WHERE YearWage = @yr AND MonthWage = @mn AND VendorCode = @VCode";
    
    using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connect"].ConnectionString))
    {
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@yr", yr);
            cmd.Parameters.AddWithValue("@mn", mn);
            cmd.Parameters.AddWithValue("@VCode", VCode);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            PageRecordDataSet.Tables.Clear();
            PageRecordDataSet.Tables.Add(dt);
        }
    }
}

https://wphtml.com/html/tf/duralux-demo/analytics.html
