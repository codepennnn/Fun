<script>
    window.addEventListener('DOMContentLoaded', () => {
        const list = document.querySelector('#MainContent_Employee_Surrender_Approval_Record_Applied_NOC_Attach_Download_0');
        if (list) {
            list.querySelectorAll('a').forEach(link => {
                const url = decodeURIComponent(link.href);

                // Extract filename after the last underscore ('_') and add as title
                const fileName = url.substring(url.lastIndexOf('_') + 1);

                // Set the tooltip to show only the filename (not the full URL)
                link.setAttribute('title', fileName);
            });
        }
    });
</script>
