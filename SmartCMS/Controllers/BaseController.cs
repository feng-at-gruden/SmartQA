using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Data.Entity;
using SmartCMS.Helpers;

namespace SmartCMS.Controllers
{
    public class BaseController : Controller
    {

        public class DB
        {
            public class Log
            {
                public void add() { }
            }

            public class Users
            {
                public void FirstOrDefault() { }
            }

            public void Dispose(){}
        };

        DB db = new DB();

        public class User { };



        protected override void Dispose(bool disposing)
        {
            if (disposing && db != null)
            {
                db.Dispose();
                db = null;
            }
            base.Dispose(disposing);
        }


        protected User CurrentUser
        {
            get
            {
                FormsIdentity fi = System.Web.HttpContext.Current.User.Identity as FormsIdentity;
                //var u = db.Users.FirstOrDefault(m => m.UserName.Equals(fi.Name, StringComparison.CurrentCultureIgnoreCase));
                return null;
            }
        }


        protected void Log(string action)
        {
            Log(action, CurrentUser);
        }

        protected void Log(string action, User u)
        {
            String ip = NetworkHelper.GetClientIPv4Address();
            String userClient = Request.Browser.Browser + " " + Request.Browser.Version + " (" + Request.Browser.Platform + ")";

            /*
            db.Log.Add(new Log
            {
                UserId = u.Id,
                Action = action,
                ActionTime = DateTime.Now,
                IP = ip,
                Client = userClient
            });
            db.SaveChanges();
             * */
        }

       
    }
}
