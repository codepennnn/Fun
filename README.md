using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ComplianceDBTS_API.Services;

[ApiController]
[Route("oauth")]
public class AuthController : ControllerBase
{
    private readonly TokenService _tokenService;
    private readonly IConfiguration _configuration;

    public AuthController(TokenService tokenService, IConfiguration configuration)
    {
        _tokenService = tokenService;
        _configuration = configuration;
    }

    [HttpPost("token")]
    public IActionResult GetToken([FromForm] OAuthTokenRequest request)
    {
        if (request == null || request.Grant_Type != "password")
            return BadRequest("Invalid grant_type");

        var configUsername = _configuration["AuthCredentials:Username"];
        var configPassword = _configuration["AuthCredentials:Password"];

        if (request.Username == configUsername && request.Password == configPassword)
        {
            var token = _tokenService.GenerateToken(request.Username);
            return Ok(new
            {
                access_token = token,
                token_type = "Bearer",
                expires_in = 1800 // or read from config
            });
        }

        return Unauthorized("Invalid username or password.");
    }

    public class OAuthTokenRequest
    {
        public string Grant_Type { get; set; } // must be "password"
        public string Username { get; set; }
        public string Password { get; set; }
    }




    public class TokenService
{
    private readonly IConfiguration _configuration;

    public TokenService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public string GenerateToken(string username)
    {
        var jwtSettings = _configuration.GetSection("JwtSettings");
        var key = Encoding.UTF8.GetBytes(jwtSettings["Key"]);
        var expiry = DateTime.UtcNow.AddMinutes(Convert.ToDouble(jwtSettings["DurationInMinutes"]));

        var claims = new[]
        {
            new Claim(ClaimTypes.Name, username),
            new Claim(JwtRegisteredClaimNames.Sub, username),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

        var token = new JwtSecurityToken(
            issuer: jwtSettings["Issuer"],
            audience: jwtSettings["Audience"],
            claims: claims,
            expires: expiry,
            signingCredentials: new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256)
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
}
