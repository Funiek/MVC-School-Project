using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace KOM_P.Models
{
    [Table("Product")]
    public partial class Product
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        [Key]
        public int Id { get; set; }

        public int CategoryId { get; set; }

        public int? DescriptionId { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DateOfAdding { get; set; }

        public bool? ForPromo { get; set; }

        public bool? Visible { get; set; }

        [StringLength(100)]
        public string SKU { get; set; }

        [StringLength(100)]
        public string Name { get; set; }

        public decimal? Price { get; set; }
    }
}
