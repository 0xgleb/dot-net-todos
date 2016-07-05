using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extensions
{
    public static class StringExtensions
    {
        public static string Shorten(this string entered)
        {
            if (entered == null)
                return "";

            string[] wordsArray = entered.Split(' ');

            string shorten = wordsArray[0];
            for (int i = 1, length = wordsArray.Length; i < length; i++)
                shorten += " " + wordsArray[i];

            return shorten;
        }
    }
}