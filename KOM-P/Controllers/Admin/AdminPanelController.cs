using KOM_P.Data;
using KOM_P.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KOM_P.Controllers.Admin
{
    public class AdminPanelController : Controller
    {
        private StoreDbContext _db;

        public AdminPanelController(StoreDbContext db)
        {
            ViewData["Admin"] = "Tak";
            _db = db;
        }
        public class IndexViewModel
        {
            public int counter { get; set; }
        }
        public IActionResult Index()
        {
            IndexViewModel model = new IndexViewModel();
            model.counter = _db.GetCounter();
            return View(model);
        }
    }
}
