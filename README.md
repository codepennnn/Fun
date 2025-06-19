using Microsoft.AspNetCore.Authentication.Cookies;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllersWithViews();

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Login";
        options.LogoutPath = "/Account/Logout";
    });

var app = builder.Build();

// Middleware
app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
____________

using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.DirectoryServices.AccountManagement;
using System.Security.Claims;

namespace YourApp.Controllers
{
    public class AccountController : Controller
    {
        public IActionResult Login()
        {
            ViewBag.ADID = Environment.UserName; // Get current system AD ID
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string adid, string password)
        {
            if (ValidateCredentials(adid, password))
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

        public IActionResult Logout()
        {
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login");
        }

        private bool ValidateCredentials(string username, string password)
        {
            using (var context = new PrincipalContext(ContextType.Domain))
            {
                return context.ValidateCredentials(username, password);
            }
        }
    }
}

_________
@{
    ViewData["Title"] = "Login";
}

<h2>AD Login</h2>

<form asp-action="Login" method="post">
    <div class="form-group">
        <label for="adid">AD ID</label>
        <input type="text" id="adid" class="form-control" value="@ViewBag.ADID" disabled />
        <input type="hidden" name="adid" value="@ViewBag.ADID" />
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="password" class="form-control" required />
    </div>
    <button type="submit" class="btn btn-primary mt-2">Login</button>
</form>

@if (!ViewData.ModelState.IsValid)
{
    <div class="text-danger">
        @foreach (var error in ViewData.ModelState.Values.SelectMany(v => v.Errors))
        {
            <p>@error.ErrorMessage</p>
        }
    </div>
}

