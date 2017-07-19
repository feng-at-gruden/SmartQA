using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartCMS.Extensions
{
    public static class MyExtension
    {


        public static string FormatHtml(this string fmt)
        {
            string formattedString = fmt.Trim();

            try
            {
                formattedString = fmt.Replace("\r", "<br/>");
            }
            catch (FormatException) { } //logging string arguments were not correct
            return formattedString;
        }

    }
}