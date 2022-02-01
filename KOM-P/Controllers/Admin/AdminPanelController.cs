using KOM_P.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Xml;

namespace KOM_P.Controllers.Admin
{
    public class AdminPanelController : Controller
    {
        private StoreDbContext _db;

        public AdminPanelController(StoreDbContext db)
        {
            _db = db;
        }
        public class IndexViewModel
        {
            public int counter { get; set; }
        }
        public IActionResult Index()
        {
            ViewData["Admin"] = "Tak";
            IndexViewModel model = new IndexViewModel();
            model.counter = _db.GetCounter();
            return View(model);
        }

        public async Task<IActionResult> ReindexPricesAsync()
        {
            HttpClient httpClient = new HttpClient();
            HttpRequestHeaders requestHeaders = httpClient.DefaultRequestHeaders;
            requestHeaders.Add("Accept", "application/xml");

            Task<HttpResponseMessage> httpResponse = httpClient.GetAsync("http://api.nbp.pl/api/exchangerates/tables/A");
            HttpResponseMessage httpResponseMessage = httpResponse.Result;
            HttpContent content = httpResponseMessage.Content;
            Task<string> responseData = content.ReadAsStringAsync();

            string data = responseData.Result;

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(data);

            XmlNode item = doc.SelectSingleNode("ArrayOfExchangeRatesTable").SelectSingleNode("ExchangeRatesTable").SelectSingleNode("Rates");

            List<NBPData> list = new List<NBPData>();

            foreach (XmlNode itemNode in item.ChildNodes)
            {
                NBPData nbp = new NBPData();
                nbp.currency = itemNode.SelectSingleNode("Code").InnerText;
                nbp.price = itemNode.SelectSingleNode("Mid").InnerText;
                list.Add(nbp);
            }

            foreach (NBPData nbp in list)
            {
                Console.WriteLine(nbp.currency + " " + nbp.price);
            }

            List<Product> products = await _db.Product.ToListAsync();

            foreach(Product product in products)
            {
                List<ProductPrice> priceList = _db.ProductPrice.Where(p => p.ProductId == product.ProductId).ToList();
                foreach(ProductPrice price in priceList)
                {

                }
            }

            return RedirectToAction("Index");
        }
    }
}
