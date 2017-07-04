using System;
using System.Collections;
using System.Linq;
using System.Web;

namespace SmartCMS.Helper
{
    public class ChatHelper
    {
        private static Hashtable _mChatData;

        public static Hashtable MChatData
        {
            get
            {
                if (_mChatData == null)
                {
                    InitChatData();
                }
                return _mChatData;
            }

            set
            {
                _mChatData = value;
            }
        }

        public static string GetAnswer(string q)
        {
            string k = "";
            q = q.ToLower().Trim();
            if (MChatData.Contains(q))
            {
                string[] answer = (string[])MChatData[q];
                int t = new Random().Next(0, answer.Length - 1);
                k = answer.GetValue(t).ToString();
            }
            return k;
        }


        private static void InitChatData()
        {
            string[] greetingQ = new string[] { "你好", "Hi", "Hello", "how are you", "hey", "good"};
            string[] greetingA = new string[] { "你好， 我是智库机器人。", "Hello", "Hi", "你好", "How are you?"};

            _mChatData = new Hashtable();
            foreach(string k in greetingQ)
            {
                _mChatData.Add(k.ToLower(), greetingA);
            }
            
        }

    }
}