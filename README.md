// DropDown validation
['Block_unblock', 'Reason'].forEach(id => {
    let el = document.querySelector("[id$='" + id + "']");
    if (el) {
        if (el.tagName === 'SELECT' && el.value === "M") {
            el.style.border = '2px solid red';
            isValid = false;
        }
    }
});
