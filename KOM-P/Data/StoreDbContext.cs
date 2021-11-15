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
        public virtual DbSet<StoreData> StoreData { get; set; }

        //CATEGORY

        //PRODUCT
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

        //USER
        public User GetUser(User siteUser,string password)
        {
            string login;

            if (siteUser != null && password != null)
            {
                login = siteUser.Login;
                User user = null;
                user = User.FromSqlRaw("GetUser @login={0}, @password={1}", login, password).ToListAsync().Result.FirstOrDefault();
                return (user != null) ? user : null;
            }
            return null;
        }

        public void CreateUser(User siteUser, string password)
        {
            string login;
            string email;

            if (siteUser != null && password != null)
            {
                login = siteUser.Login;
                email = siteUser.Email;
                Database.ExecuteSqlRaw("CreateUser @login={0}, @password={1}, @email={2}", login, password, email);
            }
        }

        //STORE

        public int GetCounter()
        {
            SqlParameter ret = new SqlParameter();
            ret.ParameterName = "@counter";
            ret.SqlDbType = System.Data.SqlDbType.VarChar;
            ret.Size = 30;
            ret.Direction = System.Data.ParameterDirection.Output;
            Database.ExecuteSqlRaw("GetCounter @counter={0} OUTPUT", ret);
            return int.Parse(ret.Value.ToString());
        }

        public void IncrementCounter()
        {
            int counter = GetCounter()+1;
            Database.ExecuteSqlRaw("UpdateCounter @counter={0}", counter.ToString());
        }
    }
}
