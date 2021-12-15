﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace KOM_P.Models
{
    [Table("Product_Order")]
    public partial class ProductOrder
    {
        [Key]
        [Column("Product_OrderID")]
        public int ProductOrderId { get; set; }
        [Column("ProductID")]
        public int ProductId { get; set; }
        [Column("OrderID")]
        public int OrderId { get; set; }

        [ForeignKey(nameof(OrderId))]
        [InverseProperty("ProductOrder")]
        public virtual Order Order { get; set; }
        [ForeignKey(nameof(ProductId))]
        [InverseProperty("ProductOrder")]
        public virtual Product Product { get; set; }
    }
}
