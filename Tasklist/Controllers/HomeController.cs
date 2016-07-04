using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Tasklist.Controllers
{
    public class HomeController : Controller
    {
        // TODO: connect a db
        public static Tasks db = new Tasks(); // TODO: create a model

        // public static List<string> Tasks = new List<string>();

        public ActionResult Index()
        {
            var Tasks = db.Where(x => x.Value != "" || x.Value != null || x.Value.Split(' ') != null).ToList(); // check last condition in Where
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
