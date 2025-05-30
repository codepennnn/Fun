<script>
    window.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('ul.attachment-list li').forEach(item => {
            item.style.cursor = 'pointer';
            item.style.color = 'blue'; // optional: make it look clickable

            item.addEventListener('click', () => {
                const fileName = item.textContent.trim();
                
                // Construct your download URL
                const fileUrl = `/Uploads/${encodeURIComponent(fileName)}`; // Adjust this path as needed

                // Trigger download
                const a = document.createElement('a');
                a.href = fileUrl;
                a.download = fileName;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            });
        });
    });
</script>
