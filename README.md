using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;

public partial class YourPage : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DualLineChart();
        }
    }

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

            string query = @"WITH Months AS (
                                SELECT DATEFROMPARTS(YEAR(@fromDate), MONTH(@fromDate), 1) AS MonthStart 
                                UNION ALL 
                                SELECT DATEADD(MONTH, 1, MonthStart) FROM Months 
                                WHERE MonthStart < DATEFROMPARTS(YEAR(@toDate), MONTH(@toDate), 1)
                            ), 
                            WagesData AS (
                                SELECT *, 
                                       CASE  
                                            WHEN ReSubmitedOn IS NOT NULL AND ReSubmitedOn > CreatedOn 
                                            THEN ReSubmitedOn 
                                            ELSE CreatedOn 
                                       END AS EffectiveDate 
                                FROM App_Online_Wages
                            ) 
                            SELECT FORMAT(Months.MonthStart, 'MMMM') AS [Month], 
                                   YEAR(Months.MonthStart) AS [Year], 
                                   AVG(DATEDIFF(DAY, w.EffectiveDate, w.LEVEL_1_UPDATEDON)) AS Avg_Diff_Effective_to_L1,  
                                   AVG(DATEDIFF(DAY, w.LEVEL_1_UPDATEDON, w.LEVEL_2_UPDATEDON)) AS Avg_Diff_L1_to_L2 
                            FROM Months 
                            LEFT JOIN WagesData w 
                                ON (w.LEVEL_1_UPDATEDON >= Months.MonthStart 
                                    AND w.LEVEL_1_UPDATEDON < DATEADD(MONTH, 1, Months.MonthStart)) 
                            GROUP BY Months.MonthStart 
                            ORDER BY Months.MonthStart 
                            OPTION (MAXRECURSION 0)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@fromDate", fromdate);
                cmd.Parameters.AddWithValue("@toDate", todate);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt1 = new DataTable();
                    da.Fill(dt1);
                    
                    if (dt1.Rows.Count > 0)
                    {
                        List<Dictionary<string, object>> dataList = new List<Dictionary<string, object>>();

                        foreach (DataRow row in dt1.Rows)
                        {
                            Dictionary<string, object> rowData = new Dictionary<string, object>
                            {
                                { "Month", row["Month"].ToString() }, // Month name (e.g., January)
                                { "Year", Convert.ToInt32(row["Year"]) },
                                { "L1", row["Avg_Diff_Effective_to_L1"] != DBNull.Value ? Convert.ToDouble(row["Avg_Diff_Effective_to_L1"]) : 0 },
                                { "L2", row["Avg_Diff_L1_to_L2"] != DBNull.Value ? Convert.ToDouble(row["Avg_Diff_L1_to_L2"]) : 0 }
                            };

                            dataList.Add(rowData);
                        }

                        JavaScriptSerializer js = new JavaScriptSerializer();
                        HiddenField3.Value = js.Serialize(dataList);
                    }
                }
            }
        }
    }
}
