﻿namespace KOM_P.Models
{
    public class CartProduct
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public decimal PromoPrice { get; set; }
        public int Qty { get; set; }
    }
}
