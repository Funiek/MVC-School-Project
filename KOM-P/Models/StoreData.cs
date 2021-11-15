using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace KOM_P.Models
{
    public class StoreData
    {
        [Key]
        public int Id { get; set; }
        public string AttribiuteName { get; set; }
        public string AttribiuteValue { get; set; }
    }
}
