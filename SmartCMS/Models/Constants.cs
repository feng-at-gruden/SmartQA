﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartCMS.Models
{

    public class Constants 
    {

        public const string APP_NAME = "海信智库客服问答系统";
        public const string APP_VERSION = "v1.0";

        public const int Other_Category_Id = 21;      //其他问题 分类ID;

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