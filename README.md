<script>
    window.addEventListener('DOMContentLoaded', () => {
        const list = document.querySelector('#Applied_NOC_Attach_Download');
        if (list) {
            list.querySelectorAll('a').forEach(link => {
                const url = decodeURIComponent(link.href);
                const fileName = url.substring(url.lastIndexOf('_') + 1);
                link.setAttribute('title', fileName);
            });
        }
    });
</script>
