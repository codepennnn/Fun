<script>
    window.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('ul.attachment-list li').forEach(item => {
            item.style.cursor = 'pointer';
            item.style.color = 'blue'; // Optional: make it look like a link
            item.style.textDecoration = 'underline';

            // Get the file path from the server-generated attribute
            const filePath = item.getAttribute('data-value');

            if (filePath) {
                item.addEventListener('click', () => {
                    // Fix path (remove ~ and make sure it's a valid URL)
                    const url = filePath.replace(/^~\//, '/');

                    // Trigger download
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = '';
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                });
            }
        });
    });
</script>


foreach (string image in strattachments)
{
    ListItem link = new ListItem();
    link.Value = "~/Attachments/" + image;
    link.Text = image.Substring(37);
    link.Attributes.Add("data-value", link.Value); // Add this line
    link.Attributes.CssStyle.Add("text-decoration", "underline");
    link.Attributes.CssStyle.Add("color", "blue");

    ((BulletedList)PF_ESI_Record.Rows[0].FindControl("PF_ESIAttach1")).Items.Add(link);
}


