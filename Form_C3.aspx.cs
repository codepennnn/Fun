using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.Data.OleDb;
using System.Text;
using System.IO;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using System.Configuration;


namespace CLMS.App.Input
{
    public partial class Form_C3 : Classes.basePage
    {
        BL_FormC3DS blgetdata = new BL_FormC3DS();

        string strConn = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;

        App_FormC3DS dsRecords = new App_FormC3DS();
        App_FormC3DS dsRecord = new App_FormC3DS();

        DataSet dsDDL = new DataSet();

        protected override void SetBaseControls()
        {
            base.SetBaseControls();

            PageRecordsDataSet = dsRecords;
            PageRecordDataSet = dsRecord;
            PageDDLDataset = dsDDL;
            BLObject = new BL_FormC3DS();
        }

        private StringDictionary GetFilterCondition()
        {
            StringDictionary d = null;
            d = new StringDictionary();

            return d;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Vendor_dtl_Record.DataSource = PageRecordDataSet;
            //vendor_wo_dtl.DataSource = PageRecordDataSet;
            workers_Records.DataSource = PageRecordDataSet;
            if (!IsPostBack)
            {
                msg12.Visible = false;
                Vendor_dtl_Record.NewRecord();
                String Vendor_dtl_Record_ID = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
                BL_FormC3DS obj = new BL_FormC3DS();
                DataSet dsId = new DataSet();
                DataSet dsWoNo = new DataSet();
                dsId = obj.GetRecord_record_id(Session["username"].ToString());
                if (dsId != null && dsId.Tables[0].Rows.Count > 0)
                {
                    string sId = dsId.Tables[0].Rows[0]["ID"].ToString();
                    PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Merge(obj.Get_Vendor_Details(sId, Vendor_dtl_Record_ID).Tables[0]);
                    string wo_no = Work_Order_No.SelectedValue;
                    PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Merge(obj.Get_workorder_Details(wo_no, Vendor_dtl_Record_ID).Tables[0]);
                    Vendor_dtl_Record.BindData();


                }

                


                GetRecords(GetFilterCondition(), Vendor_dtl_Record.PageSize, 10, "");

                PageRecordDataSet.EnforceConstraints = false;
                Dictionary<string, object> ddlParams = new Dictionary<string, object>();
                ddlParams.Add("VCode", Session["UserName"].ToString());
                //GK
                ddlParams.Add("PE", "");
                ddlParams.Add("WorkLoc", "");
                //GK
                GetDropdowns("Company1",ddlParams);
                GetDropdowns("VendorLicNo", ddlParams);
                GetDropdowns("VendorWorkOrderNo", ddlParams);
                ddlParams.Add("CREATEDBY", Session["UserName"].ToString());
                GetDropdowns("vendor_representative", ddlParams);
                //GK
                GetDropdowns("PE");
                GetDropdowns("Locations",ddlParams);
                //GK
                //DDLicNo.DataBind();  // Remove 29-09-2022
                //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Visible = false;
                Vendor_dtl_Record.DataBind(); // Add 29-09-2022
                Work_Order_No.DataBind();
                //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("Loca")).DataBind();

            }

           
        }

        //private void Page_PreRender(object sender, EventArgs e)
        //{
        //    if (Vendor_dtl_Record.Rows.Count>0)
        //    {
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).DataBind();
        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Vendor_dtl_Record.UnbindData();
            workers_Records.UnbindData();
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["NATURE_OF_LL"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("NATURE_OF_LL")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_FROM"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_FROM")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_UPTO"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_UPTO")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["TOTAL_WORKMAN"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LLWM_STRENGTH"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LLWM_STRENGTH")).Text;

            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Deptcode"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Deptcode")).Text;
            //GK
            if(PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["PE"].ToString() == "Select")
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["PE"] = null;
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["WorkLoc"] = null;
            }
            //GK
            //PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["PE"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("PE")).Text;
            //PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["WorkLoc"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Nature"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Nature")).Text;



            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0].AcceptChanges();
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0].SetAdded();
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0].AcceptChanges();
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0].SetAdded();

            if (((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Labour_License_site")).Text == "Jamshedpur")
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_NO"] = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue;
            }
            else if (((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Labour_License_site")).Text == "Seraikela")
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_NO"] = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue;
            }
            else if (((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Labour_License_site")).Text == "Others")
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_NO"] = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue;
            }


            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["NATURE_OF_LL"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("NATURE_OF_LL")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_FROM"] =  Convert.ToDateTime( ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_FROM")).Text);
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_UPTO"] = Convert.ToDateTime(  ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_UPTO")).Text);
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["TOTAL_WORKMAN"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text;
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LLWM_STRENGTH"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LLWM_STRENGTH")).Text;

            if (((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Labour_License_site")).Text == "Others")
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["C3_CLOSER_DATE"] = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["PERIOD_CONTRACT_TO"].ToString();
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["STATUS"] = "Approved";
            }
            else
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["STATUS"] = "Pending with CC";
                //PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["STATUS"] = "Approved";

            }


            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Labour_License_site")).Text;
            //if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "")
            //{
            //    PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["STATUS"] = "Approved";
            //}
            //GK
            if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0].RowState.ToString() == "Modified")
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Updatedon"] = System.DateTime.Now;
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Updatedby"] = Session["UserName"].ToString();
            }
            //GK
            bool result = Save();
            if (result)
            {
                if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Others")
                {
                    string i_d = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
                    DataSet ds3 = new DataSet();
                    DataSet ds4 = new DataSet();
                    BL_FormC3DS obj = new BL_FormC3DS();
                    string p1 = "C_3";

                    ds3 = obj.getref(p1);
                    string ref_no = ds3.Tables[0].Rows[0]["asd"].ToString();
                    int num_n = Convert.ToInt32(ds3.Tables[0].Rows[0]["number"])+1;
                    ds4 = obj.updateref(p1, num_n);

                    ds4 = obj.formc3ref(ref_no, i_d);
               






                }


                string v_code = Session["UserName"].ToString();
                string v_name = "";
                string wo_no = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["WO_NO"].ToString();
                string subject = "";
                string msg = "";
                string cc = "";
                DataSet ds = new DataSet();
                DataSet ds1 = new DataSet();
                BL_Send_Mail blobj = new BL_Send_Mail();
                ds = blobj.Get_Vendor_mail(Session["UserName"].ToString());
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    cc = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
                }

                ds1 = blobj.Get_Vendor_name(v_code);
                if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
                {
                    v_name = ds1.Tables["App_vendor_reg"].Rows[0]["v_name"].ToString();
                }



                subject = "Application for Form C3 against work order no "+ wo_no + " has been submitted or updated by M/S "+ v_name + " (Vendor Code – "+ v_code + ")  ";
                msg = "<html><body><P><B>" //added on 04-06-2020
                              + "To<BR /> "
                              + "Contractor Cell <BR/><BR/>"
                              + "Dear Sir/Madam"
                              + "<BR /> "

                              + "M/s "+ v_name + " ("+ v_code + ") has submitted Form C3 application against work order no "+ wo_no + ", request you to please do the needful as soon as possible.<BR/>"

                              + "<BR />Link :- https://services.tsuisl.co.in/CLMS "
                              + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                              + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                              + " <BR /> "
                              + " <BR /> Note: Please do not reply as it is a system generated mail. ";


                blobj.sendmail_request("", cc, subject, msg, "");








                PageRecordDataSet.Clear();
                PageRecordsDataSet.Clear();
                btnSave.Visible = false;
                Vendor_dtl_Record.DataBind();
                workers_Records.DataBind();
                txtcal.Text = "";
                
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
            }
            else
            {
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error while saving !");
            }

        }

        public String CheckValidData()
        {
            String RetDataValid = "N";
            long MaxSize = (2 * 1024 * 1024);
            if (((FileUpload)Vendor_dtl_Record.Rows[0].FindControl("Attachment_Filename")).HasFile)
            {
                if (((FileUpload)Vendor_dtl_Record.Rows[0].FindControl("Attachment_Filename")).PostedFile.ContentLength > MaxSize)
                {
                    ((Label)Vendor_dtl_Record.Rows[0].FindControl("LblWMPFAttach")).Text = "Uploaded Project related attachment";
                    MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Uploaded Project related attachment");
                    RetDataValid = "N";
                }
            }
            return RetDataValid;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }

        protected void Vendor_dtl_Record_NewRowCreatingEvent(DataRow oRow, ref bool cancel)
        {
            oRow["ID"] = Guid.NewGuid();
        }

        protected void Vendor_dtl_Record_PreRender(object sender, EventArgs e)
        {
            //if (Vendor_dtl_Record.Rows.Count > 0)
            //{
            //    Vendor_dtl_Record.DataBind();               
            //}

            if (Vendor_dtl_Record.Rows.Count > 0)
            {

                if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Jamshedpur" || PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Seraikela")
                {
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = true;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = false;

                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = "Please Select";
                    //GK
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).Enabled = false;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Enabled = false;
                    //GK
                }
                if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Others")
                {
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = false;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = "Please Select";
                    //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Items.Insert(0, new ListItem("Please Select....", "0"));
                    //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedIndex = -1;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = true;
                    //GK
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).Enabled = true;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Enabled = true;
                    //GK
                }
                if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "")
                {
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = false;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = "Please Select";
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = false;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = "Please Select";
                    //GK
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).Enabled = false;
                    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Enabled = false;
                    //GK
                }




            }



        }

        public void showhide()
        {
        }

        protected void Work_Order_No_SelectedIndexChanged(object sender, EventArgs e)
        {




            msg12.Visible = true;
            Label1.Text ="Work Order No: " + Work_Order_No.SelectedValue.ToString();
            TextBox1.Text = Session["username"].ToString();
            Vendor_dtl_Record.Visible = false;
            workman_emp_calculate.Visible = false;
            totalwork.Visible = false;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows.Clear();
            //Session["wo"] = ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("WO_NO")).Text;
            //Session["workorder"] = Work_Order_No.SelectedValue.ToString();
            //Session["workorder"] = Work_Order_No.SelectedValue.ToString();
            //Session["workorder"] = Work_Order_No.SelectedValue.ToString();
            //Session["workorder"] = Work_Order_No.SelectedValue.ToString();

        }

        //protected void vendor_wo_dtl_NewRowCreatingEvent(DataRow oRow, ref bool cancel)
        //{
        //    oRow["ID"] = Guid.NewGuid();
        //}

        //protected void vendor_wo_dtl_PreRender(object sender, EventArgs e)
        //{

        //}

        //protected void vendor_pfesi_dtl_NewRowCreatingEvent(DataRow oRow, ref bool cancel)
        //{
        //    oRow["ID"] = Guid.NewGuid();
        //}

        //protected void ESI_APPLICABLE_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //}

        //protected void PRW_Applicable_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //}

        //protected void waqges_pfesi_pay_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //}

        protected void DDLicNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            clear1();
            String Vendor_dtl_Record_ID = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
            BL_FormC3DS obj = new BL_FormC3DS();
            DataSet dsId = new DataSet();

            string sId = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue;  // Remove 29-09-2022
            //PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Merge(obj.Get_Workman_Details(sId, Vendor_dtl_Record_ID).Tables[0]);
            dsId = obj.Get_Workman_Details(sId, Vendor_dtl_Record_ID, Session["username"].ToString());
            if (dsId != null || dsId.Tables["App_Vendor_form_C3_Dtl"].Rows.Count > 0)
            {
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("NATURE_OF_LL")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["NATURE_OF_LL"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_FROM")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_FROM"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_UPTO")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_UPTO"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["TOTAL_WORKMAN"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_REMARKS")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_REMARKS"].ToString();
                
            }



            DataSet dsId_1 = new DataSet();
            DataSet dsId_2 = new DataSet();
            DataSet dsId_3 = new DataSet();
            int sum=0,i;
            dsId_1 = obj.get_wo(((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue);
            dsId_3=obj.get_wo_1(((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue);

            dsId_1.Merge(dsId_3);

            if (dsId_1 != null && dsId_1.Tables[0].Rows.Count > 0)
            {

                for (i = 0; i < dsId_1.Tables[0].Rows.Count; i++)
                {

                    string work_order = dsId_1.Tables["App_Vendor_form_C3_Dtl"].Rows[i]["WO_NO"].ToString();

                    dsId_2 = obj.get_sum(work_order);
                    if (dsId_2 != null && dsId_2.Tables[0].Rows.Count > 0)
                    {
                        sum = sum + Convert.ToInt32(dsId_2.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["SU_M"].ToString());
                    }
                    else 
                    {
                        sum = sum + 0;
                    }


                }

            }
            else
            {
                sum = sum + 0;
            }

            //PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LLWM_STRENGTH"]= (Convert.ToInt32(PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["TOTAL_WORKMAN"].ToString()) - sum).ToString();
            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LLWM_STRENGTH")).Text = (Convert.ToInt32(((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text) - sum).ToString();

            string author = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).SelectedValue;

           // Vendor_dtl_Record.DataBind();
            ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = sId;
            ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).SelectedValue = author;








            //    //    /*//if (ds5.Tables["App_LabourLicenseSubmission"] !=null && ds5.Tables["App_LabourLicenseSubmission"].Rows.Count > 0)
            //    //    //    {
            //    //    //        ((TextBox)vendor_labour_dtl.Rows[0].FindControl("Nature")).Text = ds5.Tables["App_LabourLicenseSubmission"].Rows[0]["Nature"].ToString();
            //    //    //        ((TextBox)vendor_labour_dtl.Rows[0].FindControl("FromDate")).Text = ds5.Tables["App_LabourLicenseSubmission"].Rows[0]["FromDate"].ToString();
            //    //    //        ((TextBox)vendor_labour_dtl.Rows[0].FindControl("ToDate")).Text = ds5.Tables["App_LabourLicenseSubmission"].Rows[0]["ToDate"].ToString();
            //    //    //        PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Merge(ds5.Tables[0]);
            //    //    //    }
            //    //    //    //else
            //    //    //    //{
            //    //    //    //    vendor_labour_dtl.NewRecord();
            //    //    //    //    ((TextBox)vendor_labour_dtl.Rows[0].FindControl("Nature")).Text = "";
            //    //    //    //    ((TextBox)vendor_labour_dtl.Rows[0].FindControl("FromDate")).Text = "";
            //    //    //    //    ((TextBox)vendor_labour_dtl.Rows[0].FindControl("ToDate")).Text = "";
            //    //    //    //}*/

        }

        protected void DDLICENCE_SelectedIndexChanged(object sender, EventArgs e)
        {
            clear1();
            if (((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLICENCE")).SelectedValue == "1")
            {
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Visible = true;
            }
            else
            {
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Visible = false;
            }
        }

        protected void workers_Records_DataRowAddingEvent(DataRow oRow, ref bool cancel)
        {
            PageRecordsDataSet.EnforceConstraints = false;
            oRow["ID"] = Guid.NewGuid();
            oRow["MASTER_ID"] = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
        }

        //protected void btnadded_Click(object sender, EventArgs e)
        //{
            
        //    workers_Records.AddDataRow();
        //    workers_Records.AddDataRow();
        //    workers_Records.AddDataRow();
        //    workers_Records.AddDataRow();
        //    workers_Records.AddDataRow();

        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["EMP_TYPE"] = "UNSKILLED";
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["EMP_TYPE"] = "SEMISKILLED";
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["EMP_TYPE"] = "SKILLED";
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["EMP_TYPE"] = "HIGHLYSKILLED";
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["EMP_TYPE"] = "OTHERS";

        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["V_CODE"] = (Session["username"].ToString());
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["V_CODE"] = (Session["username"].ToString());
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["V_CODE"] = (Session["username"].ToString());
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["V_CODE"] = (Session["username"].ToString());
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["V_CODE"] = (Session["username"].ToString());

        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);

        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["NO_OF_EMP_REG"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["NO_OF_EMP_REG"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["NO_OF_EMP_REG"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["NO_OF_EMP_REG"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["NO_OF_EMP_REG"] = 0;

        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["NO_OF_EMP_TEMP"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["NO_OF_EMP_TEMP"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["NO_OF_EMP_TEMP"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["NO_OF_EMP_TEMP"] = 0;
        //    PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["NO_OF_EMP_TEMP"] = 0;

        //    PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LLWM_STRENGTH"] = 0;

        //    workers_Records.BindData();
        //    btnSave.Visible = true;
        //    btnadded.Enabled = false;
        //}

        protected void btncalculate_Click(object sender, EventArgs e)
        {
        }

        protected void Vendor_dtl_Record_NewRowCreatingEvent1(DataRow oRow, ref bool cancel)
        {
            oRow["ID"] = Guid.NewGuid();
            oRow["CreatedBy"] = Session["UserName"].ToString();
            oRow["CreatedDt"] = DateTime.Now.ToString();
        }

        protected void DDLicNo_PreRender(object sender, EventArgs e)
        {
            //if (PageRecordDataSet.Tables[0].Rows.Count > 0)
            //{
            //    ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).DataBind(); // add 29-09-22
            //}
        }

        public void WM_STRENGTH()
        {
            //PageRecordsDataSet.EnforceConstraints = false;
            TextBox txt_no_of_emp_reg = new TextBox();
            TextBox txt_no_of_emp_temp = new TextBox();

            txt_no_of_emp_reg.Text = Convert.ToInt32(PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["NO_OF_EMP_REG"]).ToString();
            txt_no_of_emp_temp.Text = Convert.ToInt32(PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["NO_OF_EMP_TEMP"]).ToString();
            //if (!string.IsNullOrEmpty(txt_no_of_emp_reg.Text) && !string.IsNullOrEmpty(txt_no_of_emp_temp.Text))
            //{
            //    txtcal.Text = ((txt_no_of_emp_reg.Text) + (txt_no_of_emp_temp.Text));
            //    //txtcal.Text = (Convert.ToInt32(txt_no_of_emp_reg.Text).ToString() + Convert.ToInt32(txt_no_of_emp_temp.Text)).ToString();
            //}

        }        

        //protected void btncalculate_Click1(object sender, EventArgs e)
        //{
        //    HIDETEXTBOX();
        //}

        //public void HIDETEXTBOX()
        //{
        //    txtcal.Enabled = false;
        //}

        protected void AUTHOR_NAME_DataBound(object sender, EventArgs e)
        {
            if (Vendor_dtl_Record.Rows.Count > 0)
            {
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).Items.Insert(0, new ListItem("----Please Select--- ", ""));
            }
            
            
        }

        protected void AUTHOR_NAME_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Vendor_dtl_Record_ID = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
            BL_FormC3DS obj = new BL_FormC3DS();
            DataSet dsId = new DataSet();
            string ll_no = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue;
            string sId = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).SelectedValue;
            string createdby = Session["username"].ToString();
            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Merge(obj.Get_AUTHOR_Details(sId, createdby, Vendor_dtl_Record_ID).Tables[0]);

            
            Vendor_dtl_Record.DataBind();
            ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).SelectedValue = sId;
            ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = ll_no;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
           
            msg12.Visible = false;
            Vendor_dtl_Record.Visible = true;
            workman_emp_calculate.Visible = true;
            totalwork.Visible = true;
            BL_FormC3DS obj = new BL_FormC3DS();
            DataSet dsId = new DataSet();
            String Vendor_dtl_Record_ID = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
            string wo_no = Work_Order_No.SelectedValue.Substring(0, 10);
            dsId = obj.Get_workorder_Details(wo_no, Vendor_dtl_Record_ID);
            if (dsId != null && dsId.Tables[0].Rows.Count > 0)
            {
                PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Merge(obj.Get_workorder_Details(wo_no, Vendor_dtl_Record_ID).Tables[0]);
                Vendor_dtl_Record.BindData();
                btnSave.Enabled = true;
            }
            else 
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "esi_Exempt", "alert('Location of work not found , need to amend work order registration');", true);
                btnSave.Enabled = false;
            }

            
            if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Jamshedpur" || PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Seraikela")
            {
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = true;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = false;

                //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = "Please Select";
                //GK
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).Enabled = false;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Enabled = false;
                //GK
            }
            if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "Others")
            {
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = false;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = "Please Select";
                //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Items.Insert(0, new ListItem("Please Select....", "0"));
                //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedIndex = -1;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = true;
                //GK
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).Enabled = true;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Enabled = true;
                //GK
            }
            if (PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Labour_License_site"].ToString() == "")
            {
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = false;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = "Please Select";
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = false;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = "Please Select";
                //GK
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).Enabled = false;
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Enabled = false;
                //GK
            }













            detailsChild();
            workers_Records.BindData();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        //protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        //{
        //    clear1();
        //   if( ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DropDownList1")).SelectedValue == "Jamshedpur" || ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DropDownList1")).SelectedValue == "Seraikela")
        //    {
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = true;
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = false;

        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = "Please Select";
        //    }
        //    if (((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DropDownList1")).SelectedValue == "Others")
        //    {
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = false;
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = "Please Select";
        //        //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Items.Insert(0, new ListItem("Please Select....", "0"));
        //        //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedIndex = -1;
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = true;
        //    }
        //    if (((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DropDownList1")).SelectedValue == "Please Select")
        //    {
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).Enabled = false;
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("DDLicNo")).SelectedValue = "Please Select";
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Enabled = false;
        //        ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = "Please Select";
        //    }

        //}

        void clear1()
        {

            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("NATURE_OF_LL")).Text = "";
            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_FROM")).Text = "";
            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_UPTO")).Text ="";
            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text ="";
            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LLWM_STRENGTH")).Text = "";
            ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_REMARKS")).Text = "";
        }

        //GK
         void lab_lic_record()
        {
            clear1();
            String Vendor_dtl_Record_ID = PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["ID"].ToString();
            BL_FormC3DS obj = new BL_FormC3DS();
            DataSet dsId = new DataSet();

            string sId = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue;  // Remove 29-09-2022
            //PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Merge(obj.Get_Workman_Details1(sId, Vendor_dtl_Record_ID).Tables[0]);
            dsId = obj.Get_Workman_Details1(sId, Vendor_dtl_Record_ID);
            if (dsId != null || dsId.Tables["App_Vendor_form_C3_Dtl"].Rows.Count > 0)
            {
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("NATURE_OF_LL")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["NATURE_OF_LL"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_FROM")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_FROM"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_VALID_UPTO")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_VALID_UPTO"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["TOTAL_WORKMAN"].ToString();

                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Deptcode")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Deptcode"].ToString();
                //((TextBox)Vendor_dtl_Record.Rows[0].FindControl("PE")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["PE"].ToString();
                //((TextBox)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["WorkLoc"].ToString();
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("Nature")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["Nature"].ToString();
                //((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LL_REMARKS")).Text = dsId.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LL_REMARKS"].ToString();

            }

            DataSet dsId_1 = new DataSet();
            DataSet dsId_2 = new DataSet();
            DataSet dsId_3 = new DataSet();
            int sum = 0, i;
            dsId_1 = obj.get_wo(((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue);
            dsId_3 = obj.get_wo_1(((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue);

            dsId_1.Merge(dsId_3);

            if (dsId_1 != null && dsId_1.Tables[0].Rows.Count > 0)
            {

                for (i = 0; i < dsId_1.Tables[0].Rows.Count; i++)
                {

                    string work_order = dsId_1.Tables["App_Vendor_form_C3_Dtl"].Rows[i]["WO_NO"].ToString();

                    dsId_2 = obj.get_sum(work_order);
                    if (dsId_2 != null && dsId_2.Tables[0].Rows.Count > 0)
                    {
                        sum = sum + Convert.ToInt32(dsId_2.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["SU_M"].ToString());
                    }
                    else
                    {
                        sum = sum + 0;
                    }


                }

            }
            else
            {
                sum = sum + 0;
            }

            if (((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text == "")
            {
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LLWM_STRENGTH")).Text = sum.ToString();
            }
            else
            {
                ((TextBox)Vendor_dtl_Record.Rows[0].FindControl("LLWM_STRENGTH")).Text = (Convert.ToInt32(((TextBox)Vendor_dtl_Record.Rows[0].FindControl("TOTAL_WORKMAN")).Text) - sum).ToString();
            }
            string author = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).SelectedValue;
            
           // Vendor_dtl_Record.DataBind();

            ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Visible = true;
            //((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).SelectedValue = sId;
            ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("AUTHOR_NAME")).SelectedValue = author;

        }
        //GK


        void detailsChild()
        {
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Clear();
            workers_Records.DataBind();
            
            workers_Records.AddDataRow();
            workers_Records.AddDataRow();
            workers_Records.AddDataRow();
            workers_Records.AddDataRow();
            workers_Records.AddDataRow();

            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["EMP_TYPE"] = "UNSKILLED";
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["EMP_TYPE"] = "SEMISKILLED";
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["EMP_TYPE"] = "SKILLED";
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["EMP_TYPE"] = "HIGHLYSKILLED";
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["EMP_TYPE"] = "OTHERS";

            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["V_CODE"] = (Session["username"].ToString());
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["V_CODE"] = (Session["username"].ToString());
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["V_CODE"] = (Session["username"].ToString());
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["V_CODE"] = (Session["username"].ToString());
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["V_CODE"] = (Session["username"].ToString());

            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["WO_NO"] = Work_Order_No.SelectedValue.Substring(0, 10);

            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["NO_OF_EMP_REG"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["NO_OF_EMP_REG"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["NO_OF_EMP_REG"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["NO_OF_EMP_REG"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["NO_OF_EMP_REG"] = 0;

            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[0]["NO_OF_EMP_TEMP"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[1]["NO_OF_EMP_TEMP"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[2]["NO_OF_EMP_TEMP"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[3]["NO_OF_EMP_TEMP"] = 0;
            PageRecordDataSet.Tables["App_Vendor_FormC3_WorkManCat"].Rows[4]["NO_OF_EMP_TEMP"] = 0;

            PageRecordDataSet.Tables["App_Vendor_form_C3_Dtl"].Rows[0]["LLWM_STRENGTH"] = 0;

            workers_Records.BindData();
            btnSave.Visible = true;
            // btnadded.Enabled = false;
        }
        //GK
       
        protected void WorkLoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("WorkLoc")).SelectedIndex > 0)
            {
                string strpe = ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("PE")).SelectedValue;
                string strwo = ((DropDownList)sender).SelectedValue;
                Dictionary<string, object> ddlParams = new Dictionary<string, object>();
                ddlParams.Add("PE", strpe);
                ddlParams.Add("WorkLoc", strwo);
                GetDropdowns("Company1", ddlParams);
                ((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).DataBind();
                if(((DropDownList)Vendor_dtl_Record.Rows[0].FindControl("companyLL")).Items.Count > 0 )
                   lab_lic_record();
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Please select another Principal Employer or Work Location')", true);
            }

        }
        
        //GK
    }
}