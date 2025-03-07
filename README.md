   protected void Btn_next_Click(object sender, EventArgs e)
            {

                string otherdedu = ((TextBox)Calculation_Record.Rows[0].FindControl("OtherDeduAmt")).Text;
                string bankstatemen = ((TextBox)Calculation_Record.Rows[0].FindControl("BankStatementSlNo")).Text;
                if (otherdedu != null && otherdedu != "" && bankstatemen != null && bankstatemen != "")
                {
                    string vendorcode = txtVendorCode.Text;
                    string workorder = ddlWorkorder.SelectedValue.ToString();
                    string net_fnf = ((TextBox)Calculation_Record.Rows[0].FindControl("Total_FNF_Net_Amount")).Text;
                    DataSet ds = new DataSet();
                    DataSet ds1 = new DataSet();
                    BL_Full_N_Final_Settlement_Vendor blobj = new BL_Full_N_Final_Settlement_Vendor();



                    con = new SqlConnection(strcon);
                    cmd = new SqlCommand();
                    cmd.Connection = con;
                    con.Open();
                    string query_comp = "update App_FNF_Summary set OtherDeduAmt='"+ otherdedu + "' ,BankStatementSlNo='"+ bankstatemen + "',Total_FNF_Net_Amount='" + net_fnf + "' where VendorCode='" + vendorcode + "' and ID='"+ Summary_Records.SelectedDataKey.Value.ToString() + "' and WorkorderNo='"+ workorder + "' and Comp_MasterID='"+ Hidden_RefnoID.Value + "'  ";
                    cmd.CommandText = query_comp;
                    cmd.ExecuteNonQuery();


                    ds = blobj.Getadhar(vendorcode, workorder);
                    if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["AdharNo"].ToString() != "" && ds.Tables[0].Rows[0]["AdharNo"].ToString() != null)
                    {
                        this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Success !!!', 'Before Proceed Next Kindly update leave data of every Workman ( " + ds.Tables[0].Rows[0]["AdharNo"].ToString() + " ) !!! Thank you', 'error');", true);
                    }
                    else
                    {
                        ds1 = blobj.Getadhar_bankstatement_missing(vendorcode, workorder);
                    if (ds1.Tables[0].Rows.Count > 0 && ds1.Tables[0].Rows[0]["AdharNo"].ToString() != "" && ds1.Tables[0].Rows[0]["AdharNo"].ToString() != null)
                    {
                        this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Success !!!', 'Before Proceed Next Kindly provide Bank Staatement Sl.No. and Other Deduction data of every Workman ( " + ds1.Tables[0].Rows[0]["AdharNo"].ToString() + " ) !!! Thank you', 'error');", true);
                    }
                    else {

                        div_Attachment.Visible = true;

                        DataSet ds3 = new DataSet();
                        ds3 = blobj.Getfnf_compliance(Hidden_RefnoID.Value);
                        if (ds3.Tables[0].Rows.Count > 0)
                        {
                            PageRecordDataSet.Tables["App_FNF_Compliance"].Merge(ds3.Tables[0]);

                            AttachModeOfSepration_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["AttachModeOfSepration"].ToString();
                            AttachForm13_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["AttachForm13"].ToString();
                            AttachAttRegister_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["AttachAttRegister"].ToString();
                            AttachWageRegister_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["AttachWageRegister"].ToString();
                            Leave_certified_Attachment_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["Leave_certified_Attachment"].ToString();
                            Bonus_certified_Attachment_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["Bonus_certified_Attachment"].ToString();
                            Bank_Payment_Proof_Attachment_Hidden.Value = PageRecordDataSet.Tables["App_FNF_Compliance"].Rows[0]["Bank_Payment_Proof_Attachment"].ToString();
                        }




                        Attachment_Record.BindData();
                    }

                    }


                }
                else {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Success !!!', 'Please Provide Other Deduction Amount & Bank Statement Sl.No. !!!', 'error');", true);
                }




            }
