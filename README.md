if (!DbstsAttachment.HasFile)
{
    MyMsgBox.show(MyMsgBox.MessageType.Error, "DBSTS Mail Attachment is required!");
    return;  // stop saving
}

function validateAttachment() {
    var fileInput = document.getElementById("<%= DbstsAttachment.ClientID %>");
    if (fileInput.value === "") {
        alert("Please upload the DBSTS mail attachment.");
        return false;
    }
    return true;
}
