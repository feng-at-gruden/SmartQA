using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Collections;

namespace SmartCMS.Models
{

    public class Constants 
    {

        public const string APP_NAME = "漳州交警支队智库问答系统";
        public const string APP_VERSION = "v1.0";

        public static int Other_Category_Id { get { return int.Parse(ConfigurationManager.AppSettings["PendingQuestionsCategoryID"]); } }


        public const String UploadFolder = "/Upload/Attachment/";

        public class Roles
        {
            public const string ROLE_ADMIN = "管理员";
            public const string ROLE_CHIEF_EDITOR = "主编";
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



        public const int AnswerScore = 2;
        public const int LikeScore = 2;
        public const int UnlikeScore = 1;

        //TODO
        public static String GetUserLevel(int score)
        {


            return "小星星";
        }



    }

    

    


}
