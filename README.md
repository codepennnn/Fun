protected void WorkOrderNo_SelectedIndexChanged1(object sender, EventArgs e)
{
    GridViewRow gr = (GridViewRow)((DropDownList)sender).NamingContainer;
    string workno = ((DropDownList)sender).SelectedValue;

    if (workno != null)
    {
        BL_AttRegisterNext blobj = new BL_AttRegisterNext();
        DataSet ds = blobj.Getworkno(workno);

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            string locOfWork = ds.Tables[0].Rows[0]["LOC_OF_WORK"].ToString();

            DropDownList ddlLocationCode = (DropDownList)gr.FindControl("LocationCode");
            DropDownList ddlSiteID = (DropDownList)gr.FindControl("SiteID");

            // Check if the value exists before assigning
            if (ddlLocationCode.Items.FindByValue(locOfWork) != null)
            {
                ddlLocationCode.SelectedValue = locOfWork;
            }
            else
            {
                // Optionally handle case where value not present in dropdown
                ddlLocationCode.SelectedIndex = -1;
            }

            Dictionary<string, object> ddlParam = new Dictionary<string, object>();
            ddlParam.Add("Location", locOfWork);

            GetDropdowns("SiteByLocation", ddlParam);
            
            ddlSiteID.SelectedIndex = 0;
            ddlSiteID.DataBind();
        }
        else
        {
            DropDownList ddlLocationCode = (DropDownList)gr.FindControl("LocationCode");
            DropDownList ddlSiteID = (DropDownList)gr.FindControl("SiteID");

            ddlLocationCode.DataBind();
            ddlSiteID.DataBind();
        }
    }
}
