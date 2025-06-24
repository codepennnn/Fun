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
               ((DropDownList)gr.FindControl("LocationCode")).Text = ds.Tables[0].Rows[0]["LOC_OF_WORK"].ToString();

               //((DropDownList)gr.FindControl("LocationCode")).DataBind();

               Dictionary<string, object> ddlParam = new Dictionary<string, object>();

               ddlParam.Add("Location", ((DropDownList)gr.FindControl("LocationCode")).Text);

               GetDropdowns("SiteByLocation", ddlParam);
               ((DropDownList)gr.FindControl("SiteID")).SelectedIndex = 0;
               ((DropDownList)gr.FindControl("SiteID")).DataBind();


           }
           else
           {
               ((DropDownList)gr.FindControl("LocationCode")).DataBind();
               ((DropDownList)gr.FindControl("SiteID")).DataBind();
           }
       }
