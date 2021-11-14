using KOM_P.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace KOM_P.Data
{
    public class StoreDbContext : DbContext, IStoreDbContext
    {
        public StoreDbContext(DbContextOptions<StoreDbContext> options) : base(options)
        {

        }

        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<Product> Product { get; set; }
        public virtual DbSet<User> User { get; set; }

        public List<Product> GetProducts(int? count)
        {
            if (count != null)
            {
                SqlParameter sqlParameter = new SqlParameter("@count", count);
                //return Database.SqlQuery<Product>("SelectPromoProducts @count", sqlParameter).ToList();
                return Product.FromSqlRaw("SelectPromoProducts @count={0}", sqlParameter).ToListAsync().Result;
            }
            else return Product.FromSqlRaw("SelectAllProducts").ToListAsync().Result;
        }

        public string GetHash(HashAlgorithm hashAlgorithm, string input)
        {
            byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(input));

            var sBuilder = new StringBuilder();

            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            return sBuilder.ToString();
        }
        public User GetElement(User siteUser)
        {
            string login;
            string password;

            if (siteUser != null)
            {
                using (SHA256 shahash = SHA256.Create())
                {
                    login = siteUser.Login;
                    password = GetHash(shahash, siteUser.PasswordHash);
                    User user = null;
                    user = User.FromSqlRaw("GetUser @login={0}, @password={1}", login, password).ToListAsync().Result.FirstOrDefault();
                    return (user != null) ? user : null;

                }
            }
            return null;
        }
    }
}
