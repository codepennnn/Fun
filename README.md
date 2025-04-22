<script>
    window.addEventListener('DOMContentLoaded', () => {
        const list = document.querySelector('#MainContent_Employee_Surrender_Approval_Record_Applied_NOC_Attach_Download_0');
        if (list) {
            list.querySelectorAll('a').forEach(link => {
                const url = decodeURIComponent(link.href);

                // Extract the filename after the last underscore ('_') and show that as link text
                const fileName = url.substring(url.lastIndexOf('_') + 1);

                // Replace the href link with a dummy link to prevent it showing in the status bar
                link.setAttribute('href', '#');
                
                // Optionally, set the custom title (tooltip) as the filename
                link.setAttribute('title', fileName);

                // Replace the visible text with a more general name, like "Download Attachment" or the filename
                link.innerText = 'Download Attachment';  // Or use fileName if you prefer
            });
        }
    });
</script>
