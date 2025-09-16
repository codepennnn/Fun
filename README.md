   public void Tracelog(string start, string end, string taskname, string status)
   {

       SqlConnection con3 = new SqlConnection("Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123");
       con3.Open();
       String s1 = "Insert into App_JUSCOTASKDETAILS (UPDATEDAT,UPDATEDBY,STARTTIME,ENDTIME,TASKNAME,STATUS) values('" + System.DateTime.Now + "','000001','" + start + "','" + end + "','" + taskname + "','" + status + "') ";
       SqlCommand cmd = new SqlCommand(s1, con3);
       cmd.ExecuteNonQuery();
       con3.Close();

   }

Tracelog(start, DateTime.Now.ToString(), "HelpDesk_Complaint_Close", "No complaints to update");

    public void Tracelog(string start, string end, string taskname, string status)
    {

        SqlConnection con3 = new SqlConnection("Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123");
        con3.Open();
        String s1 = "Insert into App_JUSCOTASKDETAILS (UPDATEDAT,UPDATEDBY,STARTTIME,ENDTIME,TASKNAME,STATUS) values('" + System.DateTime.Now + "','000001','" + start + "','" + end + "','" + taskname + "','" + status + "') ";
        SqlCommand cmd = new SqlCommand(s1, con3);
        cmd.ExecuteNonQuery();
        con3.Close();

    }
