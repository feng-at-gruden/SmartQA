using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartCMS.Models
{

    public class Configurations 
    {

        public const string APP_NAME = "智库QA系统";

        public class Roles
        {
            public const string ROLE_ADMIN = "管理员";
            public const string ROLE_EDITOR = "编辑";
            public const string ROLE_SERVICE = "客服";
        }


        public class ConfigurationKey
        {
            public const string CON_KEY_SMTP_HOST = "_smtpHost";
            public const string CON_KEY_SMTP_PORT = "_smtpHostPort";
            public const string CON_KEY_SMTP_FROM_ADDRESS = "_smtpFromAddress";
            public const string CON_KEY_SMTP_PASSWORD = "_smtpFromPassword";
            public const string CON_KEY_SMTP_NEED_AUTH = "_smtpAuth";
        }

    }

    

    


}