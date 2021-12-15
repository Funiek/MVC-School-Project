using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace KOM_P.Models
{
    public partial class User
    {
        public User()
        {
            Comment = new HashSet<Comment>();
            EmailNavigation = new HashSet<Email>();
            FavouriteProduct = new HashSet<FavouriteProduct>();
            Invoice = new HashSet<Invoice>();
            Order = new HashSet<Order>();
            UserUserGroup = new HashSet<UserUserGroup>();
        }

        [Key]
        [Column("UserID")]
        public int UserId { get; set; }
        [Required]
        [StringLength(30)]
        public string Login { get; set; }
        [Required]
        [MaxLength(32)]
        public byte[] PasswordHash { get; set; }
        public bool? Permission { get; set; }
        [StringLength(100)]
        public string Email { get; set; }
        [Required]
        [StringLength(100)]
        public string Name { get; set; }
        [Required]
        [StringLength(100)]
        public string Surname { get; set; }
        [Required]
        [StringLength(100)]
        public string Address { get; set; }
        [StringLength(13)]
        public string Phone { get; set; }

        [InverseProperty("User")]
        public virtual ICollection<Comment> Comment { get; set; }
        [InverseProperty("User")]
        public virtual ICollection<Email> EmailNavigation { get; set; }
        [InverseProperty("User")]
        public virtual ICollection<FavouriteProduct> FavouriteProduct { get; set; }
        [InverseProperty("User")]
        public virtual ICollection<Invoice> Invoice { get; set; }
        [InverseProperty("User")]
        public virtual ICollection<Order> Order { get; set; }
        [InverseProperty("User")]
        public virtual ICollection<UserUserGroup> UserUserGroup { get; set; }
    }
}
