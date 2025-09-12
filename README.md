                                        <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Remarks" ValidateEmptyText="true"></asp:CustomValidator>



                                        my custom validator works

                                         <asp:Button ID="btnSave" runat="server"  Text="Submit" OnClick="btnSave_Click" CssClass="btn btn-sm btn-info" ValidationGroup="Save" OnClientClick="return validateCompliance();" />
