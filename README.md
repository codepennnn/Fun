{
  "ApiSettings": {
    "ApiKey": "YourExistingApiKey"
  },
  "JwtSettings": {
    "Key": "YourSuperStrongJwtSecretKey123456",
    "Issuer": "WorkOrderExemptionApi",
    "Audience": "WorkOrderUsers",
    "ExpiresInMinutes": 60
  }
}



using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace WorkOrderExemtionApi.Services
{
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

            var claims = new[]
            {
                new Claim(ClaimTypes.Name, username)
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings["Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var expiry = DateTime.Now.AddMinutes(double.Parse(jwtSettings["ExpiresInMinutes"]));

            var token = new JwtSecurityToken(
                issuer: jwtSettings["Issuer"],
                audience: jwtSettings["Audience"],
                claims: claims,
                expires: expiry,
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }





using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using WorkOrderExemtionApi.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllers();
builder.Services.AddSingleton<TokenService>();

// JWT Authentication Configuration
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        var jwtSettings = builder.Configuration.GetSection("JwtSettings");
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = jwtSettings["Issuer"],
            ValidAudience = jwtSettings["Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings["Key"]))
        };
    });

builder.Services.AddAuthorization();

var app = builder.Build();

app.UseMiddleware<WorkOrderExemtionApi.Middleware.ApiKeyMiddleware>(); // Your existing API key logic

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();





[ApiController]
[Route("[controller]")]
public class AuthController : ControllerBase
{
    private readonly TokenService _tokenService;

    public AuthController(TokenService tokenService)
    {
        _tokenService = tokenService;
    }

    [HttpPost("login")]
    public IActionResult Login([FromBody] LoginRequest request)
    {
        // For simplicity, hardcoded validation. Replace with real user validation.
        if (request.Username == "admin" && request.Password == "password")
        {
            var token = _tokenService.GenerateToken(request.Username);
            return Ok(new { token });
        }

        return Unauthorized("Invalid username or password.");
    }
}

public class LoginRequest
{
    public string Username { get; set; }
    public string Password { get; set; }
}
