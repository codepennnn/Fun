using WorkOrderExemtionApi.DataAcess;
using WorkOrderExemtionApi.Middleware;
using WorkOrderExemtionApi.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();




var Config = builder.Configuration;
var connectionString = Config.GetConnectionString("Dbcs");
var environment = builder.Environment;
builder.Services.AddSingleton(new WorkOrderExemptionDataAcess(connectionString));
builder.Services.AddHttpContextAccessor();




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

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();


app.UseMiddleware<SecretKeyAuthorization>();


app.UseAuthorization();

app.MapControllers();

app.Run();



  "ApiKey": "jusco@123",

  "JwtSettings": {
    "Key": "YourSuperStrongJwtSecretKey123456",
    "Issuer": "WorkOrderExemptionApi",
    "Audience": "WorkOrderUsers",
    "ExpiresInMinutes": 60
  }




  
        [Authorize]
        [HttpGet("check-exemptions")]
        public async Task<IActionResult> CheckExemptions(string vendorCode, string workOrders)
        {
            try
            {
                
                var workOrder = workOrders.Split(',', StringSplitOptions.RemoveEmptyEntries)
                                          .Select(w => w.Trim())
                                          .FirstOrDefault();

                if (string.IsNullOrWhiteSpace(workOrder))
                    return BadRequest("Invalid work order.");

                var data = await ExemtionContext.GetExemptionsAsync(vendorCode, workOrder);

                if (data == null)
                    return NotFound("No exemption found.");

                return Ok(data);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error checking exemptions");
                return StatusCode(500, "Internal server error");
            }
        }
