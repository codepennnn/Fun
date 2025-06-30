{
  "ADIDApiSettings": {
    "Url": "https://servicesdev.juscoltd.com/ADService/API/ADID/ADService",
    "ApiKeyName": "x-api-key",   // Replace with actual header name required by the API
    "ApiKeyValue": "your-secret-key-here"  // Replace with actual API key value
  }
}


namespace ADIDLoginApp.Models
{
    public class ADIDApiSettings
    {
        public string Url { get; set; }
        public string ApiKeyName { get; set; }
        public string ApiKeyValue { get; set; }
    }
}





var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddHttpClient();
builder.Services.Configure<ADIDLoginApp.Models.ADIDApiSettings>(
    builder.Configuration.GetSection("ADIDApiSettings")
);

// For Cookie Authentication
builder.Services.AddAuthentication("Cookies")
    .AddCookie("Cookies", options =>
    {
        options.LoginPath = "/Account/Login";
        options.LogoutPath = "/Account/Logout";
    });

var app = builder.Build();

app.UseAuthentication();
app.UseAuthorization();

app.MapDefaultControllerRoute();

app.Run();



using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.Extensions.Options;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using ADIDLoginApp.Models;

namespace ADIDLoginApp.Controllers
{
    public class AccountController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ADIDApiSettings _apiSettings;

        public AccountController(IHttpClientFactory httpClientFactory, IOptions<ADIDApiSettings> apiSettings)
        {
            _httpClientFactory = httpClientFactory;
            _apiSettings = apiSettings.Value;
        }

        public IActionResult Login()
        {
            ViewBag.ADID = Environment.UserName;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string adid, string password)
        {
            if (await ValidateCredentials(adid, password))
            {
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, adid),
                    new Claim("ADID", adid)
                };

                var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                var principal = new ClaimsPrincipal(identity);

                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

                return RedirectToAction("Index", "Home");
            }

            ModelState.AddModelError("", "Invalid username or password.");
            ViewBag.ADID = adid;
            return View();
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login");
        }

        private async Task<bool> ValidateCredentials(string username, string password)
        {
            var client = _httpClientFactory.CreateClient();

            var requestBody = new
            {
                ADID = username,
                Password = password
            };

            var jsonContent = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");

            // Add API Key to header
            client.DefaultRequestHeaders.Add(_apiSettings.ApiKeyName, _apiSettings.ApiKeyValue);

            try
            {
                var response = await client.PostAsync(_apiSettings.Url, jsonContent);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return false;
        }
    }
}






@{
    ViewBag.Title = "Login";
}

<h2>Login</h2>

<form method="post">
    <div>
        <label>ADID</label>
        <input type="text" name="adid" value="@ViewBag.ADID" required />
    </div>
    <div>
        <label>Password</label>
        <input type="password" name="password" required />
    </div>
    <button type="submit">Login</button>
</form>

@if (!ViewData.ModelState.IsValid)
{
    <p style="color:red;">Invalid username or password.</p>
}
