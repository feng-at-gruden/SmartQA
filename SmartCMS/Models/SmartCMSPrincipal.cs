﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Security.Principal;

namespace SmartCMS.Models
{

    public class SmartCMSPrincipal : IPrincipal
    {
        public string RoleName { get; set; }
        public string RealName { get; set; }
        public int Id { get; set; }

        private IIdentity _identity;

        public SmartCMSPrincipal(int id, string roleName, string realName, IIdentity identity)
        {
            Id = id;
            RealName = realName;
            RoleName = roleName;
            _identity = identity;
        }

        public IIdentity Identity
        {
            get { return _identity; }
        }

        public bool IsInRole(string role)
        {
            return RoleName.IndexOf(role) >= 0;
        }


        public static SmartCMSPrincipal GetUser(HttpContext httpContext)
        {
            if (httpContext.Request.IsAuthenticated)
            {
                FormsIdentity fi = httpContext.User.Identity as FormsIdentity;
                if (fi != null)
                {
                    string[] userData = fi.Ticket.UserData.Split('|');
                    if (userData.Length == 3)
                    {
                        SmartCMSPrincipal newPrincipal = new SmartCMSPrincipal(int.Parse(userData[0]),
                            userData[1],
                            userData[2],
                            httpContext.User.Identity);
                        return newPrincipal;
                    }
                    return null;
                }
                return null;
            }
            return null;
        } 
    }
}