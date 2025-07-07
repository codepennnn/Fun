void getdata()
{
    string connectionString = ConfigurationManager.ConnectionStrings["connect"].ConnectionString;

    using (SqlConnection con = new SqlConnection(connectionString))
    {
        con.Open();

        string query = "SELECT v_name, address FROM App_VendorMaster WHERE V_CODE = @V_CODE";
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@V_CODE", Session["username"].ToString());

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    ((TextBox)OnlineForm4FormID_Record.Rows[0].FindControl("Name")).Text = dr["v_name"].ToString();
                    ((TextBox)OnlineForm4FormID_Record.Rows[0].FindControl("Address")).Text = dr["address"].ToString();
                }
            }
        }
    }
}
