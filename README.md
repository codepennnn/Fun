using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using BCrypt.Net;
using Org.BouncyCastle.Crypto.Generators;
using ComplianceDBTS_API.Services;


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
        if (request == null || string.IsNullOrEmpty(request.Username) || string.IsNullOrEmpty(request.Password))
        {
            return BadRequest("Username or password is missing.");
        }

        var configUsername = _configuration["AuthCredentials:Username"];
        var configPassword = _configuration["AuthCredentials:Password"];

        if (request.Username == configUsername && request.Password == configPassword)
        {
            var token = _tokenService.GenerateToken(request.Username);
            return Ok(new { token });
        }

        return Unauthorized("Invalid username or password.");
    }


    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}



using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using RetentionMoneyApi.DataAcess;

namespace RetentionMoneyApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RetentionController : ControllerBase
    {

        private readonly RetentionDataAcessLayer Context;

        private string _connectionString;

        public RetentionController(RetentionDataAcessLayer Context)
        {
            this.Context = Context;
       
        }




        [Authorize]
        [HttpGet("RetentionMoney")]
        public async Task<IActionResult> RetentionMoneyDetail(string vendorCode, string workOrder)
        {
            if (string.IsNullOrWhiteSpace(workOrder) || string.IsNullOrWhiteSpace(vendorCode))
                return BadRequest("Please Enter Vendor code and Workorder.");

            var data = await Context.GetRetentionMoney(vendorCode, workOrder);

            return Ok(data);
        }

    }
}
