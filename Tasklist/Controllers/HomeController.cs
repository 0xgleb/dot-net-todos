using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tasklist.Models;

namespace Tasklist.Controllers
{
    public class HomeController : Controller
    {
        // TODO: connect a db
        public static TasksEntities db = new TasksEntities(); // TODO: create a model

        // public static List<string> Tasks = new List<string>();

        public ActionResult Index()
        {
            var Tasklist = from x in db.TaskTables
                           where x.Task != ""
                           select x.Task;

            ViewBag.Tasks = Tasklist;
            return View();
        }

        public ActionResult AddTask()
        {
            var form = Request.Form;

            //if (!string.IsNullOrEmpty(form["task"]))
                //db.(@form["task"]);

            return Redirect("Index");
        }
    }
}
