public string Generate_Global_RefNo(string objName)
{
    string prefix = "", postfix = "";
    int number = 0, padding = 5;

    // Step 1 — Get current number
    string sqlSelect = @"
        SELECT Prefix, Postfix, number, leftpadding 
        FROM App_Sys_AutoNumber 
        WHERE ObjName = @obj";

    Dictionary<string, object> param = new Dictionary<string, object>();
    param.Add("obj", objName);

    DataHelper dh = new DataHelper();
    DataSet ds = dh.GetDataset(sqlSelect, "App_Sys_AutoNumber", param);

    if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
        throw new Exception("AutoNumber configuration missing.");

    DataRow row = ds.Tables[0].Rows[0];

    prefix = row["Prefix"].ToString();
    postfix = row["Postfix"].ToString();
    number = Convert.ToInt32(row["number"]);
    padding = Convert.ToInt32(row["leftpadding"]);

    // Step 2 — Increment number
    number++;

    // Step 3 — Update back to DB
    string sqlUpdate = @"
        UPDATE App_Sys_AutoNumber 
        SET number = @num 
        WHERE ObjName = @obj";

    Dictionary<string, object> param2 = new Dictionary<string, object>();
    param2.Add("num", number);
    param2.Add("obj", objName);

    dh.ExecuteNonQuery(sqlUpdate, param2);

    // Step 4 — Return formatted RefNo
    return prefix + number.ToString().PadLeft(padding, '0') + postfix;
}
