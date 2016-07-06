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
        struct Task
        {
            public int id;
            public string task;
            public bool isActive;

            public Task(int id, string task, bool isActive)
            {
                this.id = id;
                this.task = task;
                this.isActive = isActive;
            }
        };

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
        public int Index(TaskTable newTask)
        {
            newTask.Task = newTask.Task.Shorten();

            if(ModelState.IsValid && newTask.Task != "")
            {
                newTask.IsActive = true;
                Tasklist.Add(newTask);
                db.TaskTables.Add(newTask);
                db.SaveChanges();
                return newTask.Id;
            }

            return -1;
        }
    }
}
