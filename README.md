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
        private const string ApiUrl = "https://servicesdev.juscoltd.com/ADService/API/ADID/ADService";
        private const string ApiKeyName = "Your-API-Key-Header-Name"; // Replace with actual header name
        private const string ApiKeyValue = "Your-API-Key-Value";      // Replace with actual key value

        public AccountController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
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

            // Prepare request payload (adjust according to your API specification)
            var requestBody = new
            {
                ADID = username,
                Password = password
            };

            var jsonContent = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");

            // Add API Key in header if required
            client.DefaultRequestHeaders.Add(ApiKeyName, ApiKeyValue);

            try
            {
                var response = await client.PostAsync(ApiUrl, jsonContent);

                if (response.IsSuccessStatusCode)
                {
                    var responseString = await response.Content.ReadAsStringAsync();
                    // Optional: parse response JSON to check specific success flag if needed
                    return true;
                }
            }
            catch (Exception ex)
            {
                // Log exception (optional)
                Console.WriteLine(ex.Message);
            }

            return false;
        }
    }
}
