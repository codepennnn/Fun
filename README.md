
       function validateCompliance() {

           var checks = document.querySelectorAll(".compliance-check input[type='checkbox']");
           var atLeastOne = Array.from(checks).some(cb => cb.checked);

           if (!atLeastOne) {
               alert("Please select at least one Compliance Type.");
               return false;
           }
           return true;
       }

             <div class="form-group col-md-3 mb-2">
          <label for="lbl_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">DBSTS Mail Attachment:<span style="color: #FF0000;">*</span></label>
          <asp:FileUpload ID="DbstsAttachment" runat="server"  Font-Size="Small" required="" />
     </div>
