public string Generate_Global_RefNo(string objName)
{
    string refNo = "";
    string prefix = "", postfix = "";
    int number = 0, padding = 5;

    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
    {
        con.Open();
        SqlTransaction tran = con.BeginTransaction();

        try
        {
            // Step 1 — Read current global number
            SqlCommand cmd = new SqlCommand(@"
                SELECT Prefix, Postfix, number, leftpadding 
                FROM App_Sys_AutoNumber 
                WHERE ObjName = @obj", con, tran);

            cmd.Parameters.AddWithValue("@obj", objName);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                prefix = dr["Prefix"].ToString();
                postfix = dr["Postfix"].ToString();
                number = Convert.ToInt32(dr["number"]);
                padding = Convert.ToInt32(dr["leftpadding"]);
            }
            dr.Close();

            // Step 2 — Increment globally (important)
            number++;

            // Step 3 — Save updated global number
            SqlCommand update = new SqlCommand(@"
                UPDATE App_Sys_AutoNumber 
                SET number = @no 
                WHERE ObjName = @obj", con, tran);

            update.Parameters.AddWithValue("@no", number);
            update.Parameters.AddWithValue("@obj", objName);
            update.ExecuteNonQuery();

            // Step 4 — Build RefNo (final output)
            refNo = prefix + number.ToString().PadLeft(padding, '0') + postfix;

            tran.Commit();
        }
        catch
        {
            tran.Rollback();
            throw;
        }
    }

    return refNo;
}

string refNo = bl.Generate_Global_RefNo("HALFYEARLY");

foreach (DataRow row in PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows)
{
    row["RefNo"] = refNo;   // SAME FOR ALL ROWS
    row["CreatedBy"] = Session["Username"].ToString();
    row["CreatedOn"] = DateTime.Now;

    row.AcceptChanges();
    row.SetAdded();
}

