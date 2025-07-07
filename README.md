.public DataSet Get_Vendor_Details(string strId, string ID)
{
    string strSQL = @"
        SELECT  
            CONVERT(uniqueidentifier, @ID) AS ID,
            v.V_CODE,
            v.V_NAME,
            v.PF_CODE_NUMBER AS PF_CODE,
            v.ESI_CODE_NUMBER AS ESI_CODE,
            v.ADDRESS AS ADDRESS,
            v.OWNER_NAME AS OWNER_NAME,
            v.PHONE_NO AS PHONE_NO,
            v.EMAIL AS EMAIL_ID,
            r.NAME AS AUTHOR_NAME,
            r.EMAIL AS AUTHOR_EMAIL,
            r.CONTACT_NO AS AUTHOR_CONTACT_NO,
            r.ADHAR_CARD AS AUTHOR_ADHAR_NUMBER,
            r.ADDRESS AS AUTHOR_ADDRESS
        FROM App_Vendor_Reg v
        INNER JOIN App_Vendor_Representative r ON r.MASTER_ID = v.ID
        WHERE v.ID = @ID_CONDITION
    ";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("ID", ID);
    objParam.Add("ID_CONDITION", strId);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
}
