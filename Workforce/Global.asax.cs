using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using NLog;
using Workforce.Controllers;

namespace Workforce
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        private static Logger _logger = LogManager.GetCurrentClassLogger();

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_Error()
        {
            var exc = Server.GetLastError().GetBaseException();

            Response.Clear();

            var httpExc = exc as HttpException;
            var routeData = new RouteData();
            routeData.Values.Add("controller", "Errors");

            if (httpExc == null)
            {
                _logger.Error(exc);
                routeData.Values.Add("action", "General");
            }
            else //It's an Http Exception, Let's handle it.
            {
                switch (httpExc.GetHttpCode())
                {
                    case 404:
                        routeData.Values.Add("action", "PageNotFound");
                        Response.StatusCode = 404;
                        break;
                    case 500:
                        _logger.Error(exc);
                        routeData.Values.Add("action", "InternalServerError");
                        break;
                    default:
                        _logger.Error(exc);
                        routeData.Values.Add("action", "General");
                        break;
                }
            }

            // Pass exception details to the target error View.
            routeData.Values.Add("Exception", exc);

            // Clear the error on server.
            Server.ClearError();

            // Avoid IIS7 getting in the middle
            Response.TrySkipIisCustomErrors = true;

            // Call target Controller and pass the routeData.
            IController errorController = new ErrorsController();
            errorController.Execute(new RequestContext(
                        new HttpContextWrapper(Context), routeData));
        }
    }
}