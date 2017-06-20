using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SmartCMS.Filters;

namespace SmartCMS.Controllers
{
    public class HomeController : BaseController
    {


        [SmartCMSAuth]
        public ActionResult Index()
        {
            return View();
        }

    }
}
