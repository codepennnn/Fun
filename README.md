

  <asp:HiddenField ID="Hidden_RefnoID" runat="server" />


       protected void Page_Load(object sender, EventArgs e)
        {
            Summary_Records.DataSource = PageRecordsDataSet;
            Leave_Records.DataSource = PageRecordDataSet;
            Bonus_Records.DataSource = PageRecordDataSet;
            Retrenchment_Record.DataSource = PageRecordDataSet;
            Gratuity_Record.DataSource = PageRecordDataSet;
            Calculation_Record.DataSource = PageRecordDataSet;
            Attachment_Record.DataSource = PageRecordDataSet;
            // FNF_Records.DataSource = PageRecordsDataSet;
            //NoticeRecords.DataSource = PageRecordDataSet;
            //Unpaid_Records.DataSource = PageRecordDataSet;


            if (!IsPostBack)
            {
                string vendorcode = Session["UserName"].ToString();
                getvendor_Details(vendorcode);
                BtnView.Visible = false;





                div_Summary.Visible = false;
                div_leave.Visible = false;
                div_bonus.Visible = false;
                div_Retrenchment.Visible = false;
                div_Gratuity.Visible = false;
                div_calculation.Visible = false;
                div_Attachment.Visible = false;
                //div_NoticePay.Visible = false;
                //div_Unpaid.Visible = false;
                BL_Full_N_Final_Settlement_Vendor bl = new BL_Full_N_Final_Settlement_Vendor();
                DataSet ds = new DataSet();
                ds = bl.Get_Grid_details(vendorcode);
                FNF_Summary_Grid.DataSource = ds.Tables[0];
                FNF_Summary_Grid.DataBind();
            }
        }
