 <div class="form-group col-md-4 col-margin mb-1">
     <asp:Label for="Block_unblock" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Block/unblock:</asp:Label>
     <asp:DropDownList ID="Block_unblock" runat="server" CssClass="form-control form-control-sm col-sm-8" OnSelectedIndexChanged="Block_unblock_SelectedIndexChanged" AutoPostBack="true">
         <asp:ListItem Text="--Select--" Value="M"></asp:ListItem>
         <asp:ListItem Text="Block" Value="RFQ_B"></asp:ListItem>
         <asp:ListItem Text="Unblock" Value="RFQ_U"></asp:ListItem>
     </asp:DropDownList>
 </div>

   <div class="form-group col-md-4 col-margin mb-1">
       <asp:Label for="Reason" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Reason:</asp:Label>
       <asp:DropDownList ID="Reason" runat="server" CssClass="form-control form-control-sm col-sm-8" OnSelectedIndexChanged="Reason_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
       <asp:TextBox ID="Status" runat="server" CssClass="form-control form-control-sm col-sm-8" Visible="false"></asp:TextBox>
   </div>




 protected void Block_unblock_SelectedIndexChanged(object sender, EventArgs e)
 {
     string Type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_Unblock")).SelectedValue;
     string connect = ConfigurationManager.ConnectionStrings["connect"].ConnectionString;
     using (SqlConnection con = new SqlConnection(connect))
     {
         using (SqlCommand cmd = new SqlCommand("select * from VENDORUNBLOCKREASON where type = '" + Type + "'"))
         {
             cmd.CommandType = CommandType.Text;
             cmd.Connection = con;
             con.Open();
             ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataSource = cmd.ExecuteReader();
             ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataTextField = "Reason";
             ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataValueField = "Reason";
             ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataBind();
             con.Close();
         }
     }
    ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).Items.Insert(0, new ListItem("--Select--", "0"));
 }




     protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
  {
      string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;
      BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
      DataSet ds = new DataSet();
      ds = blobj.GetStatus(reason);
      if (ds.Tables[0].Rows.Count > 0)
      {
          ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status")).Text = ds.Tables[0].Rows[0]["Type"].ToString();
      }
  }


  when we select type block or unblock its showing reason according this and when saving it if i select block then its status=RFQ_B else RFQ_U add this removed getstatus
