using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tasklist.Models;
using Extensions;

namespace Tasklist.Controllers
{
    public class HomeController : Controller
    {
        private static TasksEntities db = new TasksEntities(); 

        [HttpGet]
        public ActionResult Index()
        {
            var Tasklist = (from x in db.TaskTables
                           select x.Task).ToList<string>();

            ViewBag.Tasks = Tasklist;
            return View();
        }

        [HttpPost]
        public ActionResult Index(TaskTable newTask)
        {
            //var form = Request.Form;

            //TaskTable newTask = new TaskTable();

            //newTask.Task = (@form["task"]).Shorten();
            //newTask.IsActive = true;

            //if (newTask.Task != "")
            if(ModelState.IsValid)
            {
                newTask.IsActive = true;
                newTask.Task = newTask.Task.Shorten();
                // TODO: Set id somehow!!!
                db.TaskTables.Add(newTask);
                db.SaveChanges();

                return RedirectToAction("Index");
            }
            else
                return Redirect("Index");
        }
    }
}
