using KOM_P.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace KOM_P.Data
{
    interface IStoreDbContext
    {
        DbSet<Category> Category { get; set; }
        DbSet<Product> Product { get; set; }
        DbSet<User> User { get; set; }

        public List<Product> GetProducts(int? count);

        public string GetHash(HashAlgorithm hashAlgorithm, string input);
        public User GetElement(User siteUser);
    }
}
