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
    public class CategoriesController : Controller
    {
        private readonly StoreDbContext _context;

        public class IndexViewModel
        {
            public Product product { get; set; }
            public string productLink { get; set; }
        }
        public CategoriesController(StoreDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> Index(int? id)
        {
            List<IndexViewModel> indexViewModels = new List<IndexViewModel>();
            IndexViewModel index;
            List<Product> products = await _context.Product.Where(e=>e.CategoryId==id).ToListAsync();
            Category category = await _context.Category.FirstOrDefaultAsync(m => m.CategoryId == id);
            ViewData["CategoryName"] = category.Name;
            foreach (Product product in products)
            {
                index = new IndexViewModel();
                index.product = product;
                index.productLink = ImageService.GetImage(product.Sku, 240, 240);
                indexViewModels.Add(index);
            }
            return View(indexViewModels);
        }

        [HttpGet]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var category = await _context.Category
                .FirstOrDefaultAsync(m => m.CategoryId == id);
            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }
    }
}
