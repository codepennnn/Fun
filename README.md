<input type="password" id="passwordInput" placeholder="Enter Password" />
<button onclick="showPassword()">Show Password in Console</button>


<script>
function showPassword() {
  const password = document.getElementById('passwordInput').value;
  console.log("Password Entered:", password);
}
</script>
