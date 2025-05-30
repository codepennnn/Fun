    <script>
        window.addEventListener('DOMContentLoaded', () => {

            document.querySelectorAll('ul.attachment-list').forEach(list => {
                list.querySelectorAll('a').forEach(link => {
                    const url = decodeURIComponent(link.href);
                    const fileName = url.substring(url.lastIndexOf('_') + 1);


                    link.setAttribute('href', '#');


                    link.addEventListener('click', (e) => {
                        e.preventDefault();
                        window.location.href = url;
                    });
                });
            });
        });
    </script>  

     <asp:BulletedList runat="server" ID="PF_ESIAttach1" DisplayMode="HyperLink" Target="_blank" CssClass="attachment-list" />
