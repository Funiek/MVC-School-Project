using Microsoft.Owin;
using Owin;
using System;
using System.Configuration;

[assembly: OwinStartupAttribute(typeof(MVC_School_Project.Startup))]
namespace MVC_School_Project
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
        }
    }
}
