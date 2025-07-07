.void Naturework()
{
    string connectionString = ConfigurationManager.ConnectionStrings["connect"].ConnectionString;

    using (SqlConnection con = new SqlConnection(connectionString))
    {
        con.Open();

        string query = @"SELECT NATURE_OF_WORK 
                         FROM App_WorkOrder_Reg 
                         WHERE V_CODE = @V_CODE 
                           AND STATUS = 'Approved' 
                           AND WO_NO = @WO_NO";

        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@V_CODE", Session["username"].ToString());
            cmd.Parameters.AddWithValue("@WO_NO", DdlWORK_ORDER.SelectedValue);

            using (SqlDataReader dr1 = cmd.ExecuteReader())
            {
                if (dr1.Read())
                {
                    ((TextBox)OnlineForm4FormID_Record.Rows[0].FindControl("NatureWork")).Text = dr1["NATURE_OF_WORK"].ToString();
                }
            }
        }
    }
}
