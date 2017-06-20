using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SmartCMS.Filters;
using SmartCMS.Models;

namespace SmartCMS.Controllers
{
    public class AdminController : BaseController
    {
        

        public ActionResult Index()
        {
            return View();
        }


        [SmartCMSAuth(Roles = Configurations.Roles.ROLE_ADMIN)]
        public ActionResult Log()
        {
            DateTime et = DateTime.Now.AddMonths(-1);
            var model = from row in db.Log
                        where row.ActionTime >= et
                        orderby row.ActionTime descending
                        select new LogViewModel
                        {
                            Action = row.Action,
                            ActionTime = row.ActionTime,
                            IP = row.IP,
                            UserClient = row.Client,
                            User = row.Users != null ? row.Users.UserName + "/" + row.Users.RealName + "" : "已删除帐户"
                        };
            return View(model);
        }


        [SmartCMSAuth(Roles = Configurations.Roles.ROLE_ADMIN + "," + Configurations.Roles.ROLE_EDITOR )]
        public ActionResult Categories()
        {
            return View();
        }


        public ActionResult AddCategory(int pid)
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddCategory()
        {
            return View();
        }




        public ActionResult Log()
        {
            return View();
        }


    }
}
