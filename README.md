public string Grievance(string VendorCode)
{
    string data = "";
    using (SqlConnection con = new SqlConnection("Data Source=10.0.168.50;Initial Catalog=CLMSDB;User ID=fs;Password=p@ssW0Rd321;TrustServerCertificate=True"))
    {
        string query = @"
            SELECT 
                G.REF_NO, 
                G.CreatedOn,
                G.V_CODE,
                G.STATUS,
                G.TARGET_DT,
                ISNULL((
                    SELECT TOP 1 Revised_Date 
                    FROM App_Vendor_Grievance_Details 
                    WHERE master_id = G.ID 
                    AND Revised_Date IS NOT NULL 
                    ORDER BY CreatedOn DESC
                ), '') AS Revised_Date
            FROM App_Vendor_Grievance G
            WHERE G.STATUS='OPEN' 
              AND G.V_CODE=@VendorCode
            FOR JSON PATH;
        ";

        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
            con.Open();

            var result = cmd.ExecuteScalar();
            data = result == DBNull.Value ? "" : result.ToString();
        }
    }
    return data;
}
