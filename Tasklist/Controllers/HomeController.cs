using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Tasklist.Controllers
{
    public class HomeController : Controller
    {
        public static List<string> Tasks = new List<string>();

        public ActionResult Index()
        {
            ViewBag.Tasks = Tasks;
            return View();
        }

        public ActionResult AddTask()
        {
             var form = Request.Form;

            if (!string.IsNullOrEmpty(form["task"]))
                Tasks.Add(@form["task"]);

            return Redirect("Index");
        }
    }
}
