public string Generate_Global_RefNo(string objName)
{
    DataHelper dh = new DataHelper();

    // 1. SELECT, INCREMENT, UPDATE and return updated row in a single batch
    string sql = @"
        DECLARE @prefix VARCHAR(50), @postfix VARCHAR(50), @num INT, @pad INT;

        SELECT @prefix = Prefix, 
               @postfix = Postfix, 
               @num = number, 
               @pad = leftpadding
        FROM App_Sys_AutoNumber
        WHERE ObjName = @obj;

        -- Increment globally
        SET @num = @num + 1;

        -- Update table
        UPDATE App_Sys_AutoNumber 
        SET number = @num 
        WHERE ObjName = @obj;

        -- Return new values
        SELECT @prefix AS Prefix,
               @postfix AS Postfix,
               @num AS number,
               @pad AS leftpadding;
    ";

    Dictionary<string, object> param = new Dictionary<string, object>();
    param.Add("obj", objName);

    // 2. Execute batch query
    DataSet ds = dh.GetDataset(sql, "App_Sys_AutoNumber", param);

    if (ds.Tables[0].Rows.Count == 0)
        throw new Exception("AutoNumber row missing for " + objName);

    // 3. Read updated row
    DataRow row = ds.Tables[0].Rows[0];

    string prefix = row["Prefix"].ToString();
    string postfix = row["Postfix"].ToString();
    int number = Convert.ToInt32(row["number"]);
    int padding = Convert.ToInt32(row["leftpadding"]);

    // 4. Build final RefNo string
    return prefix + number.ToString().PadLeft(padding, '0') + postfix;
}
