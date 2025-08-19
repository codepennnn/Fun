  public DataSet GetRecords(System.Collections.Specialized.StringDictionary FilterConditions, int totalPagesize, string sortExpression)
  {
      //string strSQL = " select top 111 CR.*,HM.NEXT_STATUS,case when NEXT_STATUS!='Closed' then DATEDIFF(day,STATUS_DATE,getdate()) else null end as PendingDays from App_COMPLAINT_HELP_REGISTER CR";
      //GK
      string strSQL = " SELECT CR.*,HM.NEXT_STATUS,CR.NEXT_USER_ID,CASE WHEN HM.NEXT_STATUS != 'Closed' THEN DATEDIFF(day, CR.STATUS_DATE, GETDATE()) ELSE NULL END AS PendingDays,DATEDIFF(day, CR.CREATED_ON, GETDATE()) AS Created_vs_Current,FD.USERNAME FROM App_COMPLAINT_HELP_REGISTER CR";
      //GK
      strSQL += " LEFT JOIN App_HELPDESK_STATUS_MASTER HM ON CR.COMPLAINT_STATUS = HM.STATUS_CODE ";
      DataHelper dh = new DataHelper();
      Dictionary<string, object> objParam = null;
      if (FilterConditions != null && FilterConditions.Count > 0)
      {
          strSQL += " where 1=1";
          objParam = new Dictionary<string, object>();
          int cnt = FilterConditions.Count;
          if (FilterConditions["From_COMPLAINT_DATE"] != null && FilterConditions["To_COMPLAINT_DATE"] != null)
          {
              string ftdt = FilterConditions["From_COMPLAINT_DATE"].Substring(6, 4) + "-" + FilterConditions["From_COMPLAINT_DATE"].Substring(3, 2) + "-" + FilterConditions["From_COMPLAINT_DATE"].Substring(0, 2);
              string eddt = FilterConditions["To_COMPLAINT_DATE"].Substring(6, 4) + "-" + FilterConditions["To_COMPLAINT_DATE"].Substring(3, 2) + "-" + FilterConditions["To_COMPLAINT_DATE"].Substring(0, 2);
              strSQL += " and COMPLAINT_DATE >= Convert(datetime, '" + ftdt + "') and COMPLAINT_DATE <= Convert(datetime, '" + eddt + "')";
          }
          if (FilterConditions["STATUS_CODE"] != null)
              strSQL += " and STATUS_CODE= '" + FilterConditions["STATUS_CODE"] + "'";
          if (FilterConditions["NEXT_USER_ID"] != null)
              strSQL += " and COMPLAINT_STATUS = 'S0007' and next_user_id='" + FilterConditions["NEXT_USER_ID"].ToString() + "'";
          if (FilterConditions["Details"] != null)
              strSQL += "and VENDOR_CODE like '%" + FilterConditions["Details"] + "%' OR VENDOR_NAME like '%" + FilterConditions["Details"] + "%' OR COMPLAINT_NO like '%" + FilterConditions["Details"] + "%'";
      }
      else
      {
          strSQL += " where 1=1";
          strSQL += " and ( NEXT_STATUS = 'Awaiting for TSUISL Action'  OR NEXT_STATUS ='Forwarded for TSUISL Action')        ";
      }
      //GK
      strSQL += " order by COMPLAINT_DATE desc";
      //GK
      //strSQL += " order by COMPLAINT_NO desc";
      return dh.GetDataset(strSQL, "App_COMPLAINT_HELP_REGISTER", objParam);
  }


put this query in this withou any logic changing

SELECT CR.*,HM.NEXT_STATUS,CR.NEXT_USER_ID,CASE WHEN HM.NEXT_STATUS != 'Closed' THEN DATEDIFF(day, CR.STATUS_DATE, GETDATE()) ELSE NULL END AS PendingDays,DATEDIFF(day, CR.CREATED_ON, GETDATE()) AS Created_vs_Current,FD.USERNAME FROM App_COMPLAINT_HELP_REGISTER CR

LEFT JOIN App_HELPDESK_STATUS_MASTER HM ON CR.COMPLAINT_STATUS = HM.STATUS_CODE

OUTER APPLY
(
    SELECT TOP 1 
        (SELECT FL.USERNAME 
         FROM App_HELPDESK_FWD_LIST FL 
         WHERE FL.USERID = D.NEXT_USER_ID) AS USERNAME
    FROM App_COMPLAINT_HELP_DETAILS D
    WHERE D.MasterID = CR.ID
    ORDER BY D.CREATED_ON DESC
) FD


WHERE STATUS_CODE = 'S0007'
ORDER BY CR.COMPLAINT_DATE DESC;
