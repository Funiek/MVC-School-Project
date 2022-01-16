using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using KOM_P.Models;
using KOM_P.Services;
using Repository;
using Microsoft.AspNetCore.Http;

namespace KOM_P.Controllers
{
    public class ProductsController : Controller
    {
        private readonly StoreDbContext _context;

        public ProductsController(StoreDbContext context)
        {
            _context = context;
        }
        public class DetailsViewModel
        {
            public Product product { get; set; }
            public string productLink { get; set; }
            public string dateOfAdding { get; set; }
            public ProductPrice price { get; set; }
        }
        public async Task<IActionResult> Index()
        {
            return View(await _context.Product.ToListAsync());
        }

        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Product product = await _context.Product
                .FirstOrDefaultAsync(m => m.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }

            DetailsViewModel model = new DetailsViewModel();
            DateTime dateTime = (DateTime)product.AddDate;
            model.product = product;
            AddPrice(product, ref model);
            model.productLink = ImageService.GetImage(product.Sku, 480, 480);
            model.dateOfAdding = dateTime.ToString("dd.MM.yyyy");
            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> DetailsAsync(DetailsViewModel? temp)
        {
            Product product = await _context.Product
                .FirstOrDefaultAsync(m => m.ProductId == temp.product.ProductId);

            List<Product> cartProducts = SessionService.GetSession<List<Product>>(HttpContext.Session, "CartProducts");
            
            if(cartProducts == null) cartProducts = new List<Product>();

            cartProducts.Add(product);

            SessionService.SetSession(HttpContext.Session, "CartProducts", cartProducts);

            return RedirectToAction("Index", "Cart");
        }

        private void AddPrice(Product product, ref DetailsViewModel model)
        {
            if (ViewData["Language"].Equals("PL")) model.price = _context.Entry(product).Collection(c => c.ProductPrice).Query().
                                                             Where(p => p.ProductId == product.ProductId && p.Description == "PLN").FirstOrDefault();
            else if (ViewData["Language"].Equals("DE")) model.price = _context.Entry(product).Collection(c => c.ProductPrice).Query().
                                            Where(p => p.ProductId == product.ProductId && p.Description == "GBP").FirstOrDefault();
            else if (ViewData["Language"].Equals("GB")) model.price = _context.Entry(product).Collection(c => c.ProductPrice).Query().
                                            Where(p => p.ProductId == product.ProductId && p.Description == "EUR").FirstOrDefault();
            else model.price = _context.Entry(product).Collection(c => c.ProductPrice).Query().
                               Where(p => p.ProductId == product.ProductId && p.Description == "PLN").FirstOrDefault();

            if (model.price == null) model.price = _context.Entry(product).Collection(c => c.ProductPrice).Query().
                                       Where(p => p.ProductId == product.ProductId && p.Description == "PLN").FirstOrDefault();
            if (model.price == null)
            {
                model.price = new ProductPrice()
                {
                    Price = 0,
                    ProductId = 0,
                    Description = ""
                };
            }
        }
    }
}
