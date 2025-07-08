using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using BCrypt.Net;
using System;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly TokenService _tokenService;
    private readonly IConfiguration _configuration;

    public AuthController(TokenService tokenService, IConfiguration configuration)
    {
        _tokenService = tokenService;
        _configuration = configuration;
    }

    [HttpPost("login")]
    public IActionResult Login([FromBody] LoginRequest request)
    {
        // Null or missing check
        if (request == null || string.IsNullOrEmpty(request.Username) || string.IsNullOrEmpty(request.Password))
        {
            return BadRequest("Username or password is missing.");
        }

        var configUsername = _configuration["AuthCredentials:Username"];
        var configPasswordHash = _configuration["AuthCredentials:PasswordHash"];

        if (request.Username == configUsername && BCrypt.Net.BCrypt.Verify(request.Password, configPasswordHash))
        {
            var token = _tokenService.GenerateToken(request.Username);
            return Ok(new { token });
        }

        return Unauthorized("Invalid username or password.");
    }




    "AuthCredentials": {
  "Username": "XUser_5Qu09Z",
  "PasswordHash": "$2a$11$f5HR2gSHEW9ADzy/hO7keOJ3Cn.QxZ2dc.RiWfQ5C7mKM1VE79beW"
}
}
