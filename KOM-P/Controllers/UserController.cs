using KOM_P.Data;
using KOM_P.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace KOM_P.Controllers
{
    public class UserController : Controller
    {
        private readonly ILogger<UserController> _logger;
        private StoreDbContext _db;

        public UserController(ILogger<UserController> logger, StoreDbContext db)
        {
            _db = db;
            _logger = logger;
        }
        private bool ValidateUser(User user)
        {
            User _user = _db.GetElement(user);
            return (_user != null) ? true : false;
        }

        [HttpGet]
        public IActionResult SignIn()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(User user)
        {
            if(ValidateUser(user))
            {
                var claims = new List<Claim>()
                {
                new Claim(ClaimTypes.Name, user.Login)
                };
                var claimsIdentity = new ClaimsIdentity(claims, "CookieAuthentication");
                await HttpContext.SignInAsync("CookieAuthentication", new ClaimsPrincipal(claimsIdentity));
            }
            return RedirectToAction("Index","Home");
        }

        [HttpGet]
        public IActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public IActionResult SignUp(User user)
        {
            return View();
        }

        public async Task<IActionResult> SignOut()
        {
            await HttpContext.SignOutAsync("CookieAuthentication");
            return RedirectToAction("Index", "Home");
        }
    }
}
