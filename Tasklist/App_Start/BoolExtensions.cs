using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace System
{
    public static class BoolExtensions
    {
        public static string ToStatus(this bool isPublic)
        {
            if (isPublic)
                return "Public";
            else
                return "Private";
        }
    }
}