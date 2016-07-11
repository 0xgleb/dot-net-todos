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
        private static List<TaskTable> Tasklist = (from x in db.TaskTables
                                                select x).ToList<TaskTable>();

        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.Tasks = Tasklist;
            return View();
        }

        [HttpPost]
        public int Add(TaskTable newTask)
        {
            newTask.Task = newTask.Task.Shorten();

            if (ModelState.IsValid && newTask.Task != "")
            {
                newTask.IsActive = true;
                db.TaskTables.Add(newTask);
                db.SaveChanges();
                Tasklist.Add(newTask);
                return newTask.Id;
            }

            return -1;
        }

        [HttpPost]
        public int Change(ChangedTask changedTask)
        {
            changedTask.NewTask = changedTask.NewTask.Shorten();

            if(changedTask.NewTask != "")
            {
                db.TaskTables.Find(changedTask.Id).Task = changedTask.NewTask;
                db.SaveChanges();
                return 1;
            }
            return -1;
        }

        public class ChangedTask
        {
            public int Id { get; set; }
            public string NewTask { get; set; }
        }
    }
}
