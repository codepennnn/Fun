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
using BusinessData;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Net.Mail;

namespace CLMS.App.Input
{
    public partial class Vendor_RFQ_Block_Unblock : Classes.basePage
    {
        App_Vendor_Block_Unblock_Dataset dsRecords = new App_Vendor_Block_Unblock_Dataset();
        App_Vendor_Block_Unblock_Dataset dsRecord = new App_Vendor_Block_Unblock_Dataset();
        DataSet dsDDL = new DataSet();
        protected override void SetBaseControls()
        {

            base.SetBaseControls();
            PageRecordsDataSet = dsRecords;
            PageRecordDataSet = dsRecord;
            PageDDLDataset = dsDDL;
            BLObject = new BL_Vendor_RFQ_Block_Unblock();
        }

        private StringDictionary GetFilterCondition()
        {
            StringDictionary d = null;
            d = new StringDictionary();
            if (((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("V_Code")).Text != "")
            {
                d.Add("V_Code", ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("V_Code")).Text);
            }
            return d;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            ////Vendor_Block_Unblock_RFQ_record.SelectedIndex = -1;
            ////PageRecordDataSet.Clear();
            ////PageRecordDataSet.EnforceConstraints = false;

            Vendor_Block_Unblock_RFQ_recordsGrid.DataSource = PageRecordDataSet;
            Vendor_Block_Unblock_RFQ_record.DataSource = PageRecordDataSet;
            if (!IsPostBack)
            {
                Vendor_Block_Unblock_RFQ_record.NewRecord();
              


                Dictionary<string, object> ddlParams = new Dictionary<string, object>();
                ddlParams.Add("type", "aaa");

                GetDropdowns("RFQ_Reason", ddlParams);
                // ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataBind();
                Vendor_Block_Unblock_RFQ_recordsGrid.BindData();

            }





        }




        protected void Vendor_Block_Unblock_RFQ_record_NewRowCreatingEvent(DataRow oRow, ref bool cancel)
        {

            oRow["ID"] = Guid.NewGuid();
            oRow["Createdby"] = Session["UserName"].ToString();
            oRow["Createdon"] = System.DateTime.Now;
        }




        //protected void Block_unblock_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string Type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_Unblock")).SelectedValue;
        //    string connect = ConfigurationManager.ConnectionStrings["connect"].ConnectionString;
        //    using (SqlConnection con = new SqlConnection(connect))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("select * from VENDORUNBLOCKREASON where type = '" + Type + "'"))
        //        {
        //            cmd.CommandType = CommandType.Text;
        //            cmd.Connection = con;
        //            con.Open();
        //            ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataSource = cmd.ExecuteReader();
        //            ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataTextField = "Reason";
        //            ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataValueField = "Reason";
        //            ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataBind();
        //            con.Close();
        //        }
        //    }
        //   ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).Items.Insert(0, new ListItem("--Select--", "0"));
        //}





        protected void Block_unblock_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_Unblock")).SelectedValue;
          
            Dictionary<string, object> ddlParams = new Dictionary<string, object>();
            ddlParams.Add("type", Type);

            GetDropdowns("RFQ_Reason", ddlParams);
            ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataBind();
        }











        protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
        {
          
            string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;

            string type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_unblock")).SelectedValue;

           
            TextBox txtStatus = (TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status");
            txtStatus.Text = type;   
            txtStatus.Visible = false;
        }



        protected void V_Code_TextChanged(object sender, EventArgs e)
        {
            BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
            DataSet ds = new DataSet();
            DataSet ds1 = new DataSet();
            string vcode = ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("V_Code")).Text;
            if (vcode.Length > 5)
                ds = blobj.GetVName(vcode.Substring(5, 5));
            else
                ds = blobj.GetVName(vcode);


            ds1 = blobj.GetDetails(vcode);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("V_Name")).Text = ds.Tables[0].Rows[0]["V_Name"].ToString();
                ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Email")).Text = ds.Tables[0].Rows[0]["Email"].ToString();
                //((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("CONTACT_NO")).Text = ds.Tables[0].Rows[0]["CONTACT_NO"].ToString();
                //PageRecordDataSet.Merge(ds);
                PageRecordsDataSet.Merge(ds1);


                Vendor_Block_Unblock_RFQ_recordsGrid.DataBind();
            }
            else
            {
                ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("V_Name")).Text = "";
                ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Email")).Text = "";
               // ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("CONTACT_NO")).Text = "";
            }
        }


        
        protected void btnSave_Click(object sender, EventArgs e)
        {

            Vendor_Block_Unblock_RFQ_record.UnbindData();
            // PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["Createdon"] = System.DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");

            PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["Createdon"] = System.DateTime.Now;
            PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["Createdby"] = Session["UserName"].ToString();

            if (((FileUpload)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Attachment_Vendor")).HasFile)
            {
                string getFileName = "";
                List<string> FileList = new List<string>();
                foreach (HttpPostedFile htfiles in ((FileUpload)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Attachment_Vendor")).PostedFiles)
                {
                    getFileName = PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
                    getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                    htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
                    FileList.Add(getFileName);
                    getFileName = "";
                }
                PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["Attachment_Vendor"] = string.Join(",", FileList);
            }
            if (((FileUpload)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Attachment_Dept")).HasFile)
            {
                string getFileName = "";
                List<string> FileList = new List<string>();
                foreach (HttpPostedFile htfiles in ((FileUpload)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Attachment_Dept")).PostedFiles)
                {
                    getFileName = PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
                    getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                    htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
                    FileList.Add(getFileName);
                    getFileName = "";
                }
                PageRecordDataSet.Tables["App_RFQ_Block_Unblock"].Rows[0]["Attachment_Dept"] = string.Join(",", FileList);
            }




            bool result = Save();
            if (result)
            {
                PageRecordDataSet.Clear();
                Vendor_Block_Unblock_RFQ_record.BindData();
                Vendor_Block_Unblock_RFQ_recordsGrid.BindData();

                Vendor_Block_Unblock_RFQ_record.NewRecord();

                Vendor_Block_Unblock_RFQ_record.BindData();

                PageDDLDataset.Clear();
                ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).DataBind();



                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record Saved Successfully!");
            }
            else
            {
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error while saving !");
            }



        }



        protected void Attachment_Dept_Click(object sender, BulletedListEventArgs e)
        {
            string filePath = (sender as LinkButton).CommandArgument;
            if (filePath != "")
            {
                Response.ContentType = ContentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
                Response.TransmitFile(@"D:/Cybersoft_Doc/CLMS/Attachments/" + filePath);
                Response.End();
            }
            else
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('There is no file to Download');", true);
        }
        


        protected void Vendor_Block_Unblock_RFQ_recordsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType.ToString().ToUpper() == "DATAROW")
            {
                if (e.Row.Cells[7].Text.Trim() != "" && e.Row.Cells[7].Text.Trim() != null && e.Row.Cells[7].Text.Trim() != "&nbsp;")
                {
                    if (e.Row.Cells[7].Text == "RFQ_B")
                    {
                        e.Row.Cells[7].Text = "Block";
                        e.Row.Attributes.CssStyle.Value = "color: Red";
                    }
                    else
                    {
                        e.Row.Cells[7].Text = "UnBlock";
                        e.Row.Attributes.CssStyle.Value = "color: Green";
                    }
                }

                if (e.Row.Cells[9].Text.Trim() != "" && e.Row.Cells[9].Text.Trim() != null && e.Row.Cells[9].Text.Trim() != "&nbsp;")
                {
                    e.Row.Cells[9].Text = (Convert.ToDateTime(e.Row.Cells[9].Text)).ToString("dd-MM-yyyy");
                }

                if (e.Row.Cells[10].Text.Trim() != "" && e.Row.Cells[10].Text.Trim() != null && e.Row.Cells[9].Text.Trim() != "&nbsp;")
                {
                    e.Row.Cells[10].Text = (Convert.ToDateTime(e.Row.Cells[10].Text)).ToString("dd-MM-yyyy");
                }



                if (e.Row.Cells[12].Text.Trim() != "" && e.Row.Cells[12].Text.Trim() != null && e.Row.Cells[12].Text.Trim() != "&nbsp;")
                {
                    e.Row.Cells[12].Text = (Convert.ToDateTime(e.Row.Cells[12].Text)).ToString("dd-MM-yyyy");
                }




            }

            if (string.Equals(e.Row.RowType.ToString(), "DATAROW", StringComparison.CurrentCultureIgnoreCase))
            {
                DataRow oRow = ((DataRowView)e.Row.DataItem).Row;

                System.Web.UI.Control Attachment = e.Row.FindControl("Attachment_Dept");

                string[] attachments;
                if (!string.IsNullOrEmpty(oRow["Attachment_Dept"].ToString()))
                {
                    attachments = oRow["Attachment_Dept"].ToString().Split(',');

                    foreach (string image in attachments)
                    {
                        ListItem link = new ListItem();
                        //link.Value = "~/Attachments/" + image;
                        link.Value = "~/FileDownloadHandler.ashx?file=" + Server.UrlEncode(image);
                        link.Text = image.Substring(37);
                        link.Attributes.CssStyle.Add("text-decoration", "underline");
                        link.Attributes.CssStyle.Add("color", "blue");

                        ((BulletedList)Attachment).Items.Add(link);
                    }
                }
            }

           
            }

        }





    }
