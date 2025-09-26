public bool IsWorkOrderInExemptionPeriod(string workOrderNo)
{
    // If today's date is less than or equal to the stored exemption_cc date,
    // the work order is still inside the exemption period.
    string sql = @"
        SELECT COUNT(*)
        FROM App_WorkOrder_Exemption
        WHERE WorkOrderNo = @WorkOrderNo
          AND Status = 'Approved'
          AND GETDATE() <= exemption_cc";   // <-- direct date comparison

    Dictionary<string, object> objParam = new Dictionary<string, object>
    {
        { "@WorkOrderNo", workOrderNo }
    };

    DataHelper dh = new DataHelper();

    // Execute scalar COUNT and return true if any active record exists
    object result = dh.ExecuteScalar(sql, objParam);
    int count = (result == null || result == DBNull.Value) ? 0 : Convert.ToInt32(result);

    return count > 0;
}
