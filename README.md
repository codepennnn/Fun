<script>
    window.addEventListener('DOMContentLoaded', () => {
        const list = document.querySelector('#Applied_NOC_Attach_Download');
        if (list) {
            list.querySelectorAll('a').forEach(link => {
                const url = decodeURIComponent(link.href);

                // Extract only the filename after the last underscore
                let fileName = url.substring(url.lastIndexOf('_') + 1);

                // Or use after last slash if filenames aren't clean
                // let fileName = url.substring(url.lastIndexOf('/') + 1);

                link.setAttribute('title', fileName.trim());
            });
        }
    });
</script>
