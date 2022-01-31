using KOM_P.Models;
using KOM_P.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Repository;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KOM_P.Controllers
{
    
    public class CheckoutController : Controller
    {
        public class CheckoutProductViewModel
        {
            public CartProduct product { get; set; }
            public string productLink { get; set; }
        }
        public class CheckoutViewModel
        {
            public List<CheckoutProductViewModel> checkoutProducts { get; set; }
            public Order order { get; set; }
        }

        private readonly ILogger<CheckoutController> _logger;
        private StoreDbContext _db;

        public CheckoutController(ILogger<CheckoutController> logger, StoreDbContext db)
        {
            _db = db;
            _logger = logger;
        }

        [HttpGet]
        public IActionResult Index()
        {
            List<CartProduct> cartProducts = SessionService.GetSession<List<CartProduct>>(HttpContext.Session, "CartProducts");

            if (cartProducts == null) cartProducts = new List<CartProduct>();

            List<CheckoutProductViewModel> checkoutProducts = new List<CheckoutProductViewModel>();

            foreach (var cartProduct in cartProducts)
            {
                CheckoutProductViewModel checkoutProduct = new CheckoutProductViewModel();
                checkoutProduct.product = cartProduct;
                checkoutProduct.productLink = ImageService.GetImage(cartProduct.Sku, 100, 100);
                checkoutProducts.Add(checkoutProduct);
            }

            CheckoutViewModel checkoutViewModel = new CheckoutViewModel();

            checkoutViewModel.checkoutProducts = checkoutProducts;

            return View(checkoutViewModel);
        }

        [HttpPost]
        public async Task<IActionResult> HandleTransactionAsync(CheckoutViewModel checkoutViewModel)
        {
            Order order = new Order();
            order.Address = checkoutViewModel.order.Address;
            order.Price = 199.99M;
            order.PriceDescription = "PLN";
            order.PaymentMethod = checkoutViewModel.order.PaymentMethod;
            order.OrderDate = System.DateTime.Today;
            order.Status = "Potwierdzone";
            order.Shipping = checkoutViewModel.order.Shipping;
            order.UserName = checkoutViewModel.order.UserName;
            order.UserSurname = checkoutViewModel.order.UserSurname;
            

            List<CartProduct> cartProducts = SessionService.GetSession<List<CartProduct>>(HttpContext.Session, "CartProducts");

            if (cartProducts == null) cartProducts = new List<CartProduct>();

            List<Product> products = new List<Product>();

            foreach (var cartProduct in cartProducts)
            {
                Product product = await _db.Product.FirstOrDefaultAsync(m => m.ProductId == cartProduct.Id);

                ProductOrder productOrder = new ProductOrder();
                productOrder.ProductId = product.ProductId;
                productOrder.OrderId = order.OrderId;
                order.ProductOrder.Add(productOrder);
            }
            _db.Add(order);
            await _db.SaveChangesAsync();
            return View();
        }

        public IActionResult DescribeBuyer()
        {
            return View();
        }
    }
}
