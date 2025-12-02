     public DataSet GetRecords(System.Collections.Specialized.StringDictionary FilterConditions, int totalPagesize, string sortExpression)
     {
                   

         //string strSQL = "select * ,DATEDIFF(day, CreatedOn,getdate()) as dayscountCreatedOn,DATEDIFF(day, ResubmitedOn, getdate()) as dayscountResub from App_Half_Yearly_Details  ";
         string strSQL = "SELECT * FROM ( SELECT *, DATEDIFF(day, CreatedOn, GETDATE()) AS dayscountCreatedOn, DATEDIFF(day, ResubmitedOn, GETDATE()) AS dayscountResub, ROW_NUMBER() OVER (PARTITION BY RefNo ORDER BY CreatedOn DESC) AS rn FROM App_Half_Yearly_Details ) A WHERE A.rn = 1; ";
         DataHelper dh = new DataHelper();
         Dictionary<string, object> objParam = null;

         if (FilterConditions != null && FilterConditions.Count > 0)
         {
             strSQL += " where ";
             strSQL += " Status='" + FilterConditions["Status"] + "'     ";

             if (FilterConditions["Search_With"] != null)
                 strSQL += "and " + FilterConditions["Search_With"] + " like '%" + FilterConditions["Enter_Detail"] + "'   ";

         }
         if (sortExpression != "")
             strSQL += "order by " + sortExpression;
         return dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);

     }

     now two where clause problem
