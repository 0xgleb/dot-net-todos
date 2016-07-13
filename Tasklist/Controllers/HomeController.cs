using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tasklist.Models;

namespace Tasklist.Controllers
{
    public class HomeController : Controller
    {
        private static TasksEntities db = new TasksEntities();

        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.UserName = User.Identity.Name;
            ViewBag.Tasks = db.TaskTables;
            return View();
        }

        [HttpPost]
        public int Add(TaskTable newTask)
        {
            string userName = User.Identity.Name;

            if (ModelState.IsValid)
            {
                newTask.Owner = userName;
                newTask.IsActive = true;

                db.TaskTables.Add(newTask);
                db.SaveChanges();

                return newTask.Id;
            }

            return -1;
        }

        [HttpPost]
        public int Change(int Id, string NewTask)
        {
            db.TaskTables.Find(Id).Task = NewTask;
            db.SaveChanges();
            return 1;
        }

        [HttpPost]
        public int Remove(int? id)
        {
            if (id == null)
                return -2;

            var taskToDelete = db.TaskTables.Find(id);

            if (taskToDelete == null)
                return -1;

            db.TaskTables.Remove(taskToDelete);
            db.SaveChanges();
            return 1;
        }

        public int Done(int? id)
        {
            if (id == null)
                return -2;

            var task = db.TaskTables.Find(id);
            task.IsActive = !task.IsActive;
            db.SaveChanges();
            return 1;
        }
    }
}
