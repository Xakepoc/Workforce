using System.Web.Mvc;

namespace Workforce.Controllers
{
	public class ErrorsController : Controller
	{
		public ActionResult General()
		{
			var exc = RouteData.Values["Exception"] as System.Exception;
			ViewBag.WindowTite = "Error";
			return View("General");
		}

		public ActionResult PageNotFound()
		{
			return View("PageNotFound");
		}

		public ActionResult InternalServerError()
		{
			ViewBag.WindowTite = "Internal error";
			return View("General");
		}
	}
}
