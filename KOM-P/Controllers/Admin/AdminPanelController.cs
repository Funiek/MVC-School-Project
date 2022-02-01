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

            //List<NBPData> list = new List<NBPData>();

            Dictionary<string, string> list = new Dictionary<string, string>();

            foreach (XmlNode itemNode in item.ChildNodes)
            {
                //NBPData nbp = new NBPData();
                string currency = itemNode.SelectSingleNode("Code").InnerText;
                string price = itemNode.SelectSingleNode("Mid").InnerText;
                list.Add(currency, price);
            }
            
            List<Product> products = await _db.Product.ToListAsync();

            foreach(Product product in products)
            {
                bool[] priceSet = new bool[2];
                List<ProductPrice> priceList = _db.ProductPrice.Where(p => p.ProductId == product.ProductId).ToList();
                ProductPrice pricePLN = _db.ProductPrice.Where(p => p.ProductId == product.ProductId && p.Description.Equals("PLN")).FirstOrDefault();
                foreach (ProductPrice price in priceList)
                {
                    if(price.Description.Equals("GBP"))
                    {
                        priceSet[0] = true;
                        double priceGBP = Math.Round(double.Parse(list["GBP"].Replace('.',',')), 2);
                        price.Price = Math.Round(pricePLN.Price / (decimal)priceGBP, 2);
                        _db.ProductPrice.Update(price);
                        _db.SaveChanges();

                    }
                    else
                    {
                        priceSet[0] = false;
                    }

                    if (price.Description.Equals("EUR"))
                    {
                        priceSet[1] = true;
                        double priceEUR = Math.Round(double.Parse(list["EUR"].Replace('.', ',')), 2);
                        price.Price = Math.Round(pricePLN.Price / (decimal)priceEUR, 2);
                        _db.ProductPrice.Update(price);
                        _db.SaveChanges();
                    }
                    else
                    {
                        priceSet[1] = false;
                    }
                }

                for(int i=0; i<priceSet.Length; i++)
                {
                    if(!priceSet[i])
                    {
                        ProductPrice productPrice = new ProductPrice();
                        productPrice.Product = product;

                        if(i==0)
                        {
                            productPrice.Description = "GBP";
                            double priceGBP = Math.Round(double.Parse(list["GBP"].Replace('.', ',')), 2);
                            productPrice.Price = Math.Round(pricePLN.Price / (decimal)priceGBP, 2);

                        }
                        else if(i==1)
                        {
                            productPrice.Description = "EUR";
                            double priceEUR = Math.Round(double.Parse(list["EUR"].Replace('.', ',')), 2);
                            productPrice.Price = Math.Round(pricePLN.Price / (decimal)priceEUR, 2);
                        }

                        _db.ProductPrice.Add(productPrice);
                        _db.SaveChanges();
                    }
                }
            }

            return RedirectToAction("Index");
        }
    }
}
