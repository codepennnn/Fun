  void getdata()
  {
      SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connect"].ConnectionString);
      con.Open();
      SqlCommand cmd = new SqlCommand("select v_name ,address from App_VendorMaster where V_CODE='" + Session["username"].ToString() + "'", con);
      SqlDataReader dr= cmd.ExecuteReader();
      if(dr.Read())
      {
          ((TextBox)OnlineForm4FormID_Record.Rows[0].FindControl("Name")).Text = dr["v_name"].ToString();
          ((TextBox)OnlineForm4FormID_Record.Rows[0].FindControl("Address")).Text = dr["Address"].ToString();
      }

      con.Close();
  }
