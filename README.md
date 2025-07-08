{
  "AuthCredentials": {
    "Username": "XUser_5Qu09Z",
    "Password": "Zp!X74@JuSc0"
  }
}



var configUsername = _configuration["AuthCredentials:Username"];
var configPasswordHash = _configuration["AuthCredentials:PasswordHash"];

if (request.Username == configUsername &&
    BCrypt.Net.BCrypt.Verify(request.Password, configPasswordHash))
{
    var token = _tokenService.GenerateToken(request.Username);
    return Ok(new { token });
}
