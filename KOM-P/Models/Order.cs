using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace test222.Repository.Models
{
    public partial class Order
    {
        public Order()
        {
            Invoice = new HashSet<Invoice>();
            ProductOrder = new HashSet<ProductOrder>();
        }

        [Key]
        [Column("OrderID")]
        public int OrderId { get; set; }
        [Column("UserID")]
        public int UserId { get; set; }
        [Column("UserGroupID")]
        public int UserGroupId { get; set; }
        [Column(TypeName = "decimal(18, 2)")]
        public decimal Price { get; set; }
        [Required]
        [StringLength(50)]
        public string PaymentMethod { get; set; }
        [Required]
        [StringLength(100)]
        public string Address { get; set; }
        [Column(TypeName = "date")]
        public DateTime OrderDate { get; set; }
        [Required]
        [StringLength(50)]
        public string Status { get; set; }

        [ForeignKey(nameof(UserId))]
        [InverseProperty("Order")]
        public virtual User User { get; set; }
        [ForeignKey(nameof(UserGroupId))]
        [InverseProperty("Order")]
        public virtual UserGroup UserGroup { get; set; }
        [InverseProperty("Order")]
        public virtual ICollection<Invoice> Invoice { get; set; }
        [InverseProperty("Order")]
        public virtual ICollection<ProductOrder> ProductOrder { get; set; }
    }
}
