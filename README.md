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

                     string query = @"WITH Months AS (SELECT DATEFROMPARTS(YEAR('"+ fromdate + "'), MONTH('"+ fromdate + "'), 1) AS MonthStart UNION ALL SELECT DATEADD(MONTH, 1, MonthStart) FROM Months WHERE "
                                + " MonthStart < DATEFROMPARTS(YEAR('"+ todate + "'), MONTH('"+ todate + "'), 1)), WagesData AS ( SELECT *,CASE  WHEN ReSubmitedOn IS NOT NULL AND ReSubmitedOn > CreatedOn THEN "
                                + " ReSubmitedOn ELSE CreatedOn END AS EffectiveDate FROM App_Online_Wages) "
                                + " SELECT  MONTH(Months.MonthStart) AS [Month], YEAR(Months.MonthStart) AS [Year], "
                                + " AVG(DATEDIFF(DAY, w.EffectiveDate, w.LEVEL_1_UPDATEDON) ) AS Avg_Diff_Effective_to_L1, " 
                                + " AVG(DATEDIFF(DAY, w.LEVEL_1_UPDATEDON, w.LEVEL_2_UPDATEDON) ) AS Avg_Diff_L1_to_L2 FROM Months "
                                + " LEFT JOIN WagesData w ON (w.LEVEL_1_UPDATEDON >= Months.MonthStart "
                                + " AND w.LEVEL_1_UPDATEDON < DATEADD(MONTH, 1, Months.MonthStart)) "
                                + " GROUP BY Months.MonthStart "
                                + " ORDER BY Months.MonthStart "
                                + " OPTION (MAXRECURSION 0) ";
                  using (SqlCommand cmd = new SqlCommand(query, con))
                  {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt1 = new DataTable();
                        da.Fill(dt1);
                        if (dt1.Rows.Count > 0)
                        {
                            List<string> datalist = new List<string>();

                           //javaScriptSerializer js

                            foreach(DataRow row in dt1.Rows)
                            {
                                string rowData=$"{{Month:{row["Month"]},Year:{row["Year"]},L1:{row["Avg_Diff_Effective_to_L1"]},L2:{row["Avg_Diff_L1_to_L2"]}}}";
                                datalist.Add(rowData);
                            }

                            //string DualChartData = $"{dt1.Rows[0]["Month"]},{dt1.Rows[0]["Year"]},{dt1.Rows[0]["Avg_Diff_Effective_to_L1"]},{dt1.Rows[0]["Avg_Diff_L1_to_L2"]}";
                            HiddenField3.Value = "[" + string.Join(",", datalist) + "]";


                        }


                    }
                  }
            }
        }

        public List<string> GetMonthYearList(DateTime fromdate, DateTime todate)
        {
            List<string> months = new List<string>();
            while (fromdate <= todate)
            {
                string month = fromdate.Month.ToString() + "-" + fromdate.Year.ToString();
                months.Add(month);
                fromdate = fromdate.AddMonths(1);
            }
            return months;

        }  


        
       window.onload = function () {
           try {
               var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;
               alert("HiddenField3 value: " + hiddenField3);

 
               var formattedData = hiddenField3
                   .replace(/([{,]\s*)([A-Za-z0-9_]+)(\s*:)/g, '$1"$2"$3') 
                   .replace(/(['"])?([a-zA-Z0-9_]+)(['"])?:/g, '"$2":')     
                   .replace(/'/g, '"');                                    

               var dataPoints = JSON.parse(formattedData);
               alert("Parsed data: " + JSON.stringify(dataPoints));

               var labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
               var l1Data = dataPoints.map(dp => dp.l1);
               var l2Data = dataPoints.map(dp => dp.l2);

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
                       plugins: {
                           datalabels: {
                               color: 'black',
                               anchor: 'end',
                               align: 'bottom',
                               font: {
                                   weight: 'bold',
                                   size: 10
                               },
                               formatter: (value) => value,
                               display: (context) => context.dataset.label !== 'Average (3)'
                           }
                       },
                       scales: {
                           y: {
                               beginAtZero: true,
                               ticks: { stepSize: 1 }
                           }
                       }
                   },
                   plugins: [ChartDataLabels]
               });

           } catch (error) {
               alert("Error parsing data: " + error.message);
           }
       };

output - HiddenField3 value: [{Month:1,Year:2025,L1:1,L2:0}]
Parsed data: [{"Month":1,"Year":2025,"L1":1,"L2":0}]
pls solve my chart not showing
