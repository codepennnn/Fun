public void Tracelog(DateTime start, DateTime end, string taskname, string status)
{
    using (var con = new SqlConnection("Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123"))
    {
        string query = @"
            INSERT INTO App_JUSCOTASKDETAILS
            (UPDATEDAT, UPDATEDBY, STARTTIME, ENDTIME, TASKNAME, STATUS)
            VALUES (@UpdatedAt, @UpdatedBy, @StartTime, @EndTime, @TaskName, @Status)";

        using (var cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.Add("@UpdatedAt", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = "000001";
            cmd.Parameters.Add("@StartTime", SqlDbType.DateTime).Value = start;
            cmd.Parameters.Add("@EndTime",   SqlDbType.DateTime).Value = end;
            cmd.Parameters.Add("@TaskName",  SqlDbType.VarChar).Value = taskname;
            cmd.Parameters.Add("@Status",    SqlDbType.VarChar).Value = status;

            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
}
