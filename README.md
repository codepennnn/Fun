    <script>
        window.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('ul.attachment-list li').forEach(item => {
                item.style.cursor = 'pointer';
                item.style.color = 'blue'; 
                item.style.textDecoration = 'underline';

                
                const filePath = item.getAttribute('data-value'); //~/Attachments/d3816b98-fe98-4c2a-9d70-101bd068ded8_merged June-2024.pdf
                alert(filePath);

                if (filePath) {
                    item.addEventListener('click', () => {
                      
                        const url = filePath.replace(/^~\//, '/');

                       
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
