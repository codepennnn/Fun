private void DualLineChart()
{
    string connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connect"].ConnectionString;

    using (SqlConnection con = new SqlConnection(connectionString))
    {
        con.Open();

        string Fd = DateTime.ParseExact(txtFdt.Text, "dd/MM/yyyy", null).ToString("yyyy-MM-dd");
        DateTime fromdate = Convert.ToDateTime(Fd);
        string Td = DateTime.ParseExact(txtTdt.Text, "dd/MM/yyyy", null).ToString("yyyy-MM-dd");
        DateTime todate = Convert.ToDateTime(Td);

        string query = @"
            WITH Months AS (
                SELECT DATEFROMPARTS(YEAR(@FromDate), MONTH(@FromDate), 1) AS MonthStart
                UNION ALL
                SELECT DATEADD(MONTH, 1, MonthStart)
                FROM Months
                WHERE MonthStart < DATEFROMPARTS(YEAR(@ToDate), MONTH(@ToDate), 1)
            ),
            WagesData AS (
                SELECT *,
                    CASE WHEN ReSubmitedOn IS NOT NULL AND ReSubmitedOn > CreatedOn THEN ReSubmitedOn
                    ELSE CreatedOn END AS EffectiveDate
                FROM App_Online_Wages
            )
            SELECT 
                FORMAT(Months.MonthStart, 'MMMM') AS [Month],
                YEAR(Months.MonthStart) AS [Year],
                AVG(DATEDIFF(DAY, w.EffectiveDate, w.LEVEL_1_UPDATEDON)) AS Avg_Diff_Effective_to_L1,
                AVG(DATEDIFF(DAY, w.LEVEL_1_UPDATEDON, w.LEVEL_2_UPDATEDON)) AS Avg_Diff_L1_to_L2
            FROM Months
            LEFT JOIN WagesData w ON (
                w.LEVEL_1_UPDATEDON >= Months.MonthStart AND 
                w.LEVEL_1_UPDATEDON < DATEADD(MONTH, 1, Months.MonthStart)
            )
            GROUP BY Months.MonthStart
            ORDER BY Months.MonthStart
            OPTION (MAXRECURSION 0)";

        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@FromDate", fromdate);
            cmd.Parameters.AddWithValue("@ToDate", todate);

            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt1 = new DataTable();
                da.Fill(dt1);

                if (dt1.Rows.Count > 0)
                {
                    var dataList = dt1.AsEnumerable().Select(row => new
                    {
                        Month = row["Month"].ToString(), 
                        Year = Convert.ToInt32(row["Year"]),
                        L1 = row["Avg_Diff_Effective_to_L1"] != DBNull.Value ? Convert.ToInt32(row["Avg_Diff_Effective_to_L1"]) : 0,
                        L2 = row["Avg_Diff_L1_to_L2"] != DBNull.Value ? Convert.ToInt32(row["Avg_Diff_L1_to_L2"]) : 0
                    }).ToList();

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    HiddenField3.Value = js.Serialize(dataList);
                }
            }
        }
    }
}

using System.Web.Script.Serialization;

try {
    var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;
    alert("HiddenField3 value: " + hiddenField3);

    // Parse JSON properly
    var dataPoints = JSON.parse(hiddenField3);
    alert("Parsed data: " + JSON.stringify(dataPoints));

    var labels = dataPoints.map(dp => `${dp.Month}/${dp.Year}`);
    var l1Data = dataPoints.map(dp => dp.L1);
    var l2Data = dataPoints.map(dp => dp.L2);

    var ctx = document.getElementById('DualLineChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'L1 Data',
                    data: l1Data,
                    borderColor: 'blue',
                    backgroundColor: 'blue',
                    fill: false,
                    tension: 0.3
                },
                {
                    label: 'L2 Data',
                    data: l2Data,
                    borderColor: 'green',
                    backgroundColor: 'green',
                    fill: false,
                    tension: 0.3
                },
                {
                    label: 'Average (3)',
                    data: Array(labels.length).fill(3),
                    borderColor: 'red',
                    borderWidth: 1,
                    borderDash: [5, 5],
                    pointRadius: 0,
                    fill: false
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { stepSize: 1 }
                }
            }
        }
    });
} catch (error) {
    alert("Error parsing data: " + error.message);
}





