using KOM_P.Models;
using KOM_P.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

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

        public IActionResult HandleTransaction(CheckoutViewModel checkoutViewModel)
        {

            return View();
        }

        public IActionResult DescribeBuyer()
        {
            return View();
        }
    }
}
