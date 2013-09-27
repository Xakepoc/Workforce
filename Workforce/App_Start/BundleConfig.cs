using System.Web;
using System.Web.Optimization;

namespace Workforce
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            var styles = new StyleBundle("~/Content/css/all");
            styles.Include(
                "~/Content/css/bootstrap.css",
                "~/Content/css/dc.css",
                "~/Content/css/style.css"
                );
            bundles.Add(styles);

            var scripts = new ScriptBundle("~/js/all");
            scripts.Include("~/Scripts/jquery-{version}.js");
            scripts.Include("~/Content/js/bootstrap*");

            scripts.Include(
                "~/Scripts/jquery.unobtrusive*",
                "~/Scripts/jquery.validate*",
                "~/Scripts/underscore*",
                "~/Scripts/d3.v3*",
                "~/Scripts/crossfilter*",
                "~/Scripts/dc*"
                );
            scripts.Include("~/Content/js/charts.js");

            bundles.Add(scripts);
        }
    }
}