 <div class="col-lg-12">
    <asp:BulletedList runat="server" ID="Applied_NOC_Attach_Download" DisplayMode="HyperLink" Target="_blank" class="m-0 mt-2 mr-0 p-0 col-form-label-sm col-sm-12 font-weight-bold fs-6" />
</div>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

        <script>
            window.addEventListener('DOMContentLoaded', () => {
                const links = document.querySelectorAll('#Applied_NOC_Attach_Download');
                links.forEach(link => {

                    const url = decodeURIComponent(link.href);
                    const fileName = url.substring(url.lastIndexOf('_') + 1);
                    link.setAttribute('title', fileName);
                });
            });
</script>
</asp:Content>  not worked
