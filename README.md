{StatusCode: 404, ReasonPhrase: 'Not Found', Version: 1.1, Content: System.Net.Http.HttpConnectionResponseContent, Headers:
{
  Transfer-Encoding: chunked
  Server: Microsoft-IIS/10.0
  X-Powered-By: ASP.NET
  Date: Mon, 30 Jun 2025 06:51:24 GMT
}}


using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using System.Text;
using System.Text.Json;

namespace ADIDLoginApp.Controllers
{
    public class AccountController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public AccountController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        public IActionResult Login()
        {
            ViewBag.ADID = "746449290113";  
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

            var apiUrl = "http://10.0.168.68//ADService/API/ADID/ADService";
            var apiKeyName = "XApiKey";  
            var apiKeyValue = "CityGis#123";

       
            var requestBody = new
            {
                Domain = "tatasteel",
                PNo = username,     
                Password = password  
            };

            var jsonContent = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");
            client.DefaultRequestHeaders.Add(apiKeyName, apiKeyValue);

            try
            {
                var response = await client.PostAsync(apiUrl, jsonContent);

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
        <label>PNo</label>
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
