using KOM_P.Models;
using KOM_P.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace KOM_P.Controllers
{
    public class CartController : Controller
    {
        public class CartViewModel
        {
            public CartProduct product { get; set; }
            public string productLink { get; set; }
        }

        // GET: CartController
        public ActionResult Index()
        {

            List<CartProduct> cartProducts = SessionService.GetSession<List<CartProduct>>(HttpContext.Session, "CartProducts");

            if (cartProducts == null) cartProducts = new List<CartProduct>();

            List<CartViewModel> cartViewProducts = new List<CartViewModel>();

            foreach (var cartProduct in cartProducts)
            {
                CartViewModel cartViewModel = new CartViewModel();
                cartViewModel.product = cartProduct;
                cartViewModel.productLink = ImageService.GetImage(cartProduct.Sku, 100, 100);
                cartViewProducts.Add(cartViewModel);
            }

            return View(cartViewProducts);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            List<CartProduct> cartProducts = SessionService.GetSession<List<CartProduct>>(HttpContext.Session, "CartProducts");

            if (cartProducts == null) return View("Index", new List<CartViewModel>());

            List<CartViewModel> cartViewProducts = new List<CartViewModel>();

            CartProduct toRemove = null;

            foreach (var cartProduct in cartProducts)
            {
                if(cartProduct.Id == id)
                {
                    toRemove = cartProduct;
                    continue;
                }
                CartViewModel cartViewModel = new CartViewModel();
                cartViewModel.product = cartProduct;
                cartViewModel.productLink = ImageService.GetImage(cartProduct.Sku, 100, 100);
                cartViewProducts.Add(cartViewModel);
            }

            cartProducts.Remove(toRemove);

            SessionService.SetSession(HttpContext.Session, "CartProducts", cartProducts);

            return View("Index", cartViewProducts);
        }
    }
}
