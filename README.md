List<string> ids = new List<string>();

foreach (DataRow row in ds_L1.Tables[0].Rows)
{
    ids.Add(row["ID"].ToString());
}
