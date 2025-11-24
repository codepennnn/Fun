public List<Dictionary<string, object>> Grievance(string VendorCode)
{
    var list = new List<Dictionary<string, object>>();

    using (SqlConnection con = new SqlConnection("Data Source=10.0.168.50;Initial Catalog=CLMSDB;User ID=fs;Password=p@ssW0Rd321;TrustServerCertificate=True"))
    {
        string query = @"
            SELECT 
                G.REF_NO, 
                G.CreatedOn,
                G.V_CODE,
                G.STATUS,
                G.TARGET_DT,
                (
                    SELECT TOP 1 Revised_Date 
                    FROM App_Vendor_Grievance_Details 
                    WHERE master_id = G.ID 
                    ORDER BY CreatedOn DESC
                ) AS Revised_Date
            FROM App_Vendor_Grievance G
            WHERE G.STATUS='OPEN' 
              AND G.V_CODE=@VendorCode;
        ";

        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    var row = new Dictionary<string, object>();

                    for (int i = 0; i < dr.FieldCount; i++)
                    {
                        row[dr.GetName(i)] = dr.IsDBNull(i) ? null : dr.GetValue(i);
                    }

                    list.Add(row);
                }
            }
        }
    }

    return list;
}
