namespace MVC_School_Project.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

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
    }
}
