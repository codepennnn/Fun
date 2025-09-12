function finalValidation() {
    // run ASP.NET validators for group "Save"
    if (!Page_ClientValidate('Save')) return false;

    // then your checkbox check
    return validateCompliance();
}
