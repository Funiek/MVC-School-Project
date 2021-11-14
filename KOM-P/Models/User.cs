using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace KOM_P.Models
{
    [Table("User")]
    public partial class User
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Login")]
        [Required(ErrorMessage = "pole 'Login' jest obowiązkowe")]
        [StringLength(30)]
        public string Login { get; set; }

        [Display(Name = "Password")]
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "pole 'Password' jest obowiązkowe")]
        [StringLength(64)]
        public string PasswordHash { get; set; }

        public bool? Permission { get; set; }

        [Display(Name = "Email")]
        [StringLength(100)]
        public string Email { get; set; }
    }
}
