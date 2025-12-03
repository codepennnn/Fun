protected void Search_Click(object sender, EventArgs e)
{
  
    if (Session["UserName"] == null)
    {
       
        return;
    }



    if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Status"].ToString() == "Approved")
    {

        SearchLLBtn.Enabled = false;


    }
    else if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Status"].ToString() == "Pending With CC")
    {

        SearchLLBtn.Enabled = false;


    }
    else if (PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Status"].ToString() == "Return")
    {
        SearchLLBtn.Enabled = true;

    }

    else
    {



    }



    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue; 

 
    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.Get_Ref_NoDDL(vcode, period, year);

      
    string script14 = "document.getElementById('" + divLL.ClientID + "').style.display = 'flex';";
    ScriptManager.RegisterStartupScript(this, this.GetType(), "showBtnExportsum14", script14, true);
    SearchLLBtn.Visible = true;
    BindRefNoDropdown(ds);
 
}
