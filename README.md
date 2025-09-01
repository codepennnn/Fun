     public async Task<IEnumerable<WorkOrderExemptionResult>> GetExemptionsAsync(string vendorCode, string workOrder)
     {
         using (var connection = new SqlConnection(_connectionString))
         {
             string sql = @"
     SELECT TOP 1
         VendorCode,
         WorkOrderNo,
         CASE 
             WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
             ELSE 'NO'
         END AS IsExemption
     FROM App_WorkOrder_Exemption
     WHERE VendorCode = @VendorCode
       AND Status = 'Approved'
       AND (
             WorkOrderNo = @WorkOrder
             OR WorkOrderNo LIKE @LikePattern1
             OR WorkOrderNo LIKE @LikePattern2
             OR WorkOrderNo LIKE @LikePattern3
       )
     ORDER BY Approved_On DESC";

             var result = await connection.QueryAsync<WorkOrderExemptionResult>(sql, new
             {
                 VendorCode = vendorCode,
                 WorkOrder = workOrder,
                 LikePattern1 = workOrder + ",%",
                 LikePattern2 = "%," + workOrder + ",%",
                 LikePattern3 = "%," + workOrder
             });

             return result;
         }
     }
