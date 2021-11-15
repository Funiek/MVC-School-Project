using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using KOM_P.Data;
using KOM_P.Models;
using KOM_P.Services;

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
                .FirstOrDefaultAsync(m => m.Id == id);
            if (product == null)
            {
                return NotFound();
            }

            DetailsViewModel model = new DetailsViewModel();
            DateTime dateTime = (DateTime)product.DateOfAdding;
            model.product = product;
            model.productLink = ImageService.GetImage(product.SKU, 480, 480);
            model.dateOfAdding = dateTime.ToString("dd.MM.yyyy");
            return View(model);
        }

    }
}
