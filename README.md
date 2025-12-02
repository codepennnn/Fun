      protected void HalfYearly_Records_SelectedIndexChanged(object sender, EventArgs e)
      {
          var  Id = HalfYearly_Records.SelectedDataKey.Values;

          var Keys = PageRecordDataSet.Tables["App_Half_Yearly_Details"];


          string vcode = keys["VCode"].ToString();
          string period = keys["Period"].ToString();
          string year = keys["Year"].ToString();

          string strKey = vcode + "," + year + "," + period;


          GetRecord(strKey);

          HalfYearly_Entry_Records.BindData();
      }
