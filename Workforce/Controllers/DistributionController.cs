﻿using System.Web.Mvc;
using Workforce.Models;

namespace Workforce.Controllers
{
    public class DistributionController : Controller
    {

        public ActionResult Index()
        {
            var model = new AgeDistribution();
            return View(model);
        }

        public ActionResult Progression()
        {
            var model = new AgeDistribution();
            return View(model);
        }

        public ActionResult AgeDevelopment()
        {
            var model = new AgeDistribution();
            return View(model);
        }
    }
}