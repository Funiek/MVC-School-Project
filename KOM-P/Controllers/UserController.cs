
using KOM_P.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace KOM_P.Controllers
{
    public class UserController : Controller
    {
        public class SignInViewModel 
        { 
            public User user { get; set; }
            public string password { get; set; }
        }
            
        private readonly ILogger<UserController> _logger;
        private StoreDbContext _db;

        public UserController(ILogger<UserController> logger, StoreDbContext db)
        {
            _db = db;
            _logger = logger;
        }
        private User ValidateUser(SignInViewModel model)
        {

            User _user = _db.GetUser(model.user, model.password);
            return (_user != null) ? _user : null;
        }

        [HttpGet]
        public IActionResult SignIn()
        {
            ViewBag.SignIn = TempData["SignIn"];
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(SignInViewModel model)
        {

            User user = ValidateUser(model);
            if(user!=null)
            {
                List<Claim> claims;
                if (user.Permission==true)
                {
                    claims = new List<Claim>()
                    {
                    new Claim(ClaimTypes.Name, "Admin")
                    };
                }
                else
                {
                    claims = new List<Claim>()
                    {
                        new Claim(ClaimTypes.Name, model.user.Login)
                    };
                }
                var claimsIdentity = new ClaimsIdentity(claims, "CookieAuthentication");
                await HttpContext.SignInAsync("CookieAuthentication", new ClaimsPrincipal(claimsIdentity));
                TempData["SignIn"] = "";
                return RedirectToAction("Index", "Home");
            }

            TempData["SignIn"] = "Błąd Logowania!";
            return RedirectToAction("SignIn","User");
        }

        [HttpGet]
        public IActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SignUpAsync(SignInViewModel model)
        {
            _db.CreateUser(model.user, model.password);

            User user = ValidateUser(model);
            if (user != null)
            {
                var claims = new List<Claim>()
                {
                new Claim(ClaimTypes.Name, model.user.Login)
                };
                var claimsIdentity = new ClaimsIdentity(claims, "CookieAuthentication");
                await HttpContext.SignInAsync("CookieAuthentication", new ClaimsPrincipal(claimsIdentity));
            }
            return RedirectToAction("Index", "Home");
        }

        public async Task<IActionResult> SignOut()
        {
            await HttpContext.SignOutAsync("CookieAuthentication");
            return RedirectToAction("Index", "Home");
        }
    }
}
