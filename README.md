<script>
    window.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('ul.attachment-list li').forEach(item => {
            item.style.cursor = 'pointer';
            item.style.color = 'blue';
            item.style.textDecoration = 'underline';

            const filePath = item.getAttribute('data-value');
            console.log("Raw filePath:", filePath);

            if (filePath) {
                item.addEventListener('click', () => {
                    // Remove "~/" from path
                    const url = filePath.replace(/^~\//, '/');
                    console.log("Final URL:", url);

                    // Create temporary download link
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = url.split('/').pop(); // download with filename
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                });
            }
        });
    });
</script>
