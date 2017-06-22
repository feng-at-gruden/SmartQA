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

        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN)]
        public ActionResult Log()
        {
            DateTime et = DateTime.Now.AddMonths(-3);
            var model = from row in db.Logs
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


       




       

    }
}
