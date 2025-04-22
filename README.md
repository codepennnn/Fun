<script>
    window.addEventListener('DOMContentLoaded', () => {
        // Select all <ul> with class 'attachment-list'
        document.querySelectorAll('ul.attachment-list').forEach(list => {
            list.querySelectorAll('a').forEach(link => {
                const url = decodeURIComponent(link.href);
                const fileName = url.substring(url.lastIndexOf('_') + 1);

                // Hide real URL
                link.setAttribute('href', '#');
                link.setAttribute('title', fileName);
                link.innerText = 'Download Attachment'; // or fileName

                // Optional: Redirect on click
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    window.location.href = url;
                });
            });
        });
    });
</script>
