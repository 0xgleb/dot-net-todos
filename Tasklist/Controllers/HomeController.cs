﻿using System;
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
            if (ModelState.IsValid)
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
            db.TaskTables.Find(changedTask.Id).Task = changedTask.NewTask;
            db.SaveChanges();
            return 1;
        }

        [HttpPost]
        public int Remove(int? id)
        {
            if (id == null)
                return -2;

            var taskForDelete = db.TaskTables.Find(id);

            if (taskForDelete == null)
                return -1;

            db.TaskTables.Remove(taskForDelete);
            db.SaveChanges();
            Tasklist.RemoveAll(x => x.Id == id);
            return 1;
        }

        public class ChangedTask
        {
            public int Id { get; set; }
            public string NewTask { get; set; }
        }
    }
}
