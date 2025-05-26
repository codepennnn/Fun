public async Task<IEnumerable<ExemptionShortResult>> GetExemptionsAsync(string vendorCode, string[] workOrders)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
        SELECT 
            VendorCode,
            WorkOrderNo,
            CASE 
                WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
                ELSE 'NO'
            END AS WithinExemptionCC
        FROM App_WorkOrder_Exemption
        WHERE VendorCode = @VendorCode
          AND WorkOrderNo IN @WorkOrders
          AND Status = 'Approved'";

        var result = await connection.QueryAsync<ExemptionShortResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrders = workOrders
        });

        return result;
    }
}
