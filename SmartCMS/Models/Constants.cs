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

        public const string APP_NAME = "漳州市公安局交警支队智库系统";
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


        public class UserScore
        {
            public const int LoginScore = 1;
            public const int AnswerScore = 3;
            public const int LikeScore = 2;
            public const int UnlikeScore = 1;
            public const int AdoptedScore = 20;
            public const int AddKnowedgeScore = 10;
        }

        
        public static String GetUserLevel(int score)
        {
            if (score < 100)
                return "Lv1新手上路";
            else if (score < 300)
                return "Lv2初学乍练";
            else if (score < 500)
                return "Lv3初学乍练";
            else if (score < 700)
                return "Lv4初学乍练";
            else if (score < 1000)
                return "Lv5略有小成";
            else if (score < 1300)
                return "Lv6略有小成";
            else if (score < 1600)
                return "Lv7略有小成";
            else if (score < 1900)
                return "Lv8略有小成";
            else if (score < 2200)
                return "Lv9略有小成";
            else if (score < 2600)
                return "Lv10渐入佳境";
            else if (score < 3000)
                return "Lv11渐入佳境";
            else if (score < 3400)
                return "Lv12渐入佳境";
            else if (score < 3800)
                return "Lv13渐入佳境";
            else if (score < 4200)
                return "Lv14渐入佳境";
            else if (score < 4700)
                return "Lv15炉火纯青";
            else if (score < 5200)
                return "Lv16炉火纯青";
            else if (score < 5700)
                return "Lv17炉火纯青";
            else if (score < 6200)
                return "Lv18炉火纯青";
            else if (score < 6700)
                return "Lv19炉火纯青";
            else if (score < 7500)
                return "Lv20已臻大成";
            else if (score < 8500)
                return "Lv21已臻大成";
            else if (score < 9500)
                return "Lv22已臻大成";
            else if (score < 11000)
                return "Lv23已臻大成";
            else if (score < 13000)
                return "Lv24已臻大成";
            else if (score < 15000)
                return "Lv25登峰造极";
            else if (score < 17500)
                return "Lv26登峰造极";
            else if (score < 20000)
                return "Lv27登峰造极";
            else if (score < 25000)
                return "Lv28登峰造极";
            else if (score < 30000)
                return "Lv29登峰造极";
            else
                return "Lv30出神入化";            
        }



    }

    

    


}
