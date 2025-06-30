@{
    ViewBag.Title = "Login";
}

<h2>Login</h2>

<form method="post">
    <div>
        <label>Domain</label>
        <input type="text" name="domain" value="tatasteel" required />
    </div>
    <div>
        <label>PNo</label>
        <input type="text" name="adid" required />
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



[HttpPost]
public async Task<IActionResult> Login(string domain, string adid, string password)
{
    if (await ValidateCredentials(domain, adid, password))
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
