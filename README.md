<script>
    window.addEventListener('DOMContentLoaded', () => {
        const links = document.querySelectorAll('#Applied_NOC_Attach_Download a');
        links.forEach(link => {
            // Extract just the filename from URL
            const url = decodeURIComponent(link.href);
            const fileName = url.substring(url.lastIndexOf('_') + 1);
            link.setAttribute('title', fileName); // Show clean name on hover
        });
    });
</script>
