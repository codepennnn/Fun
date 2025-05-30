window.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('ul.attachment-list li').forEach(item => {
        item.style.cursor = 'pointer';
        item.style.color = 'blue';
        item.style.textDecoration = 'underline';

        const filePath = item.getAttribute('data-value');
        console.log("Raw filePath:", filePath);

        if (filePath) {
            item.addEventListener('click', () => {
                const url = filePath.replace(/^~\//, '/');
                console.log("Final URL:", url);

                const a = document.createElement('a');
                a.href = encodeURI(url); // Encode special characters like space
                a.download = url.split('/').pop();
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            });
        }
    });


    http://localhost:60104/Attachments/275dc2f5-67f2-41bc-9916-785419b498c1_ilovepdf_merged%2065.pdf
});
