    void Naturework()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connect"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select NATURE_OF_WORK from App_WorkOrder_Reg where  V_CODE='" + Session["username"].ToString() + "' and status='Approved' and WO_NO='" + DdlWORK_ORDER.SelectedValue + "'", con);
            SqlDataReader dr1 = cmd.ExecuteReader();
            if (dr1.Read())
            {
                ((TextBox)OnlineForm4FormID_Record.Rows[0].FindControl("NatureWork")).Text = dr1["NATURE_OF_WORK"].ToString();

            }
        con.Close();
        }
