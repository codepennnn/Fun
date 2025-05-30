item.addEventListener('click', () => {
    const fileName = filePath.replace(/^~\//, ''); // remove "~/"
    const url = '/Attachments/' + fileName; // Make sure this matches your real path

    const a = document.createElement('a');
    a.href = url;
    a.download = '';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
});
