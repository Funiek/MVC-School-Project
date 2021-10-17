using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MVC_School_Project.Startup))]
namespace MVC_School_Project
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
