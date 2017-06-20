using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SmartCMS.Controllers
{
    public class AdminController : Controller
    {
        

        public ActionResult Index()
        {
            return View();
        }



        public ActionResult Categories()
        {
            return View();
        }


        public ActionResult AddCategory(int pid)
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddCategory()
        {
            return View();
        }



    }
}
