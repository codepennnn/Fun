private string BuildEmailBody(string vcode, string vname, string complaintNo)
{
    return $@"
<html>
<body>
    <div style='text-align: justify; font-family: Arial, sans-serif;'>
        <b>
        Dear Vendor Partner, {vname} ({vcode})<br/><br/>
        We had awaited your response to the complaint you lodged - <strong>{complaintNo}</strong> for over 10 days. In the absence of any communication, we assume that either your concerns have been resolved or you no longer wish to pursue the matter. As the complaint was not formally closed from your end, we are proceeding to close it. If you were unable to respond due to any reason and still wish to raise the issue, you may submit a fresh complaint.<br/><br/>
        For any clarification please contact Contractor Cell through the Online Helpdesk:
        <a href='https://services.tsuisl.co.in/CLMS'>CLMS Online Helpdesk</a><br/><br/>
        Note: Please do not reply to this system generated mail.<br/><br/>
        Thanks &amp; Regards<br/>
        Contractors' Cell<br/>
        TATA STEEL UISL
        </b>
    </div>
</body>
</html>";
}


string taskStart = DateTime.Now.ToString();
Tracelog(taskStart, "", "Complaint_service", "Started");

try
{
    // Your existing code to select and update complaints
    foreach (DataRow row in ds.Tables[0].Rows)
    {
        // ... update complaint and send email ...
    }

    string taskEnd = DateTime.Now.ToString();
    Tracelog(taskStart, taskEnd, "Complaint_service", "Success");
}
catch (Exception ex)
{
    string taskEnd = DateTime.Now.ToString();
    Tracelog(taskStart, taskEnd, "Complaint_service", "Failed: " + ex.Message);
}
