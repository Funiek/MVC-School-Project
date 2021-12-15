using KOM_P.Data;
using KOM_P.Models;
using KOM_P.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace KOM_P.Controllers
{
    public class HomeController : Controller
    {
        public class IndexViewModel
        {
            public Product product { get; set; }
            public string productLink { get; set; }
        }

        private readonly ILogger<HomeController> _logger;
        private StoreDbContext _db;

        public HomeController(ILogger<HomeController> logger, StoreDbContext db)
        {
            _db = db;
            _logger = logger;
        }

        public ActionResult Index()
        {
            string visited = HttpContext.Session.GetString("Visited");
            if (visited == null)
            {
                _db.IncrementCounter();
                HttpContext.Session.SetString("Visited", "Yes"); 
            }

            ViewData["Permission"] = true;
            List<IndexViewModel> indexViewModels = new List<IndexViewModel>();
            IndexViewModel index;
            List<Product> products = _db.GetProducts(4);
            foreach (Product product in products)
            {
                index = new IndexViewModel();
                index.product = product;
                index.productLink = ImageService.GetImage(product.Sku,240,240);
                indexViewModels.Add(index);
            }
            return View(indexViewModels);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
