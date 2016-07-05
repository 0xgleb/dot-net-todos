﻿using System;
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
        private static List<string> Tasklist = (from x in db.TaskTables
                                                select x.Task).ToList<string>();


        private static int id = Tasklist.ToArray().Length;

        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.Tasks = Tasklist;
            return View();
        }

        [HttpPost]
        public ActionResult Index(TaskTable newTask)
        {
           newTask.Task = newTask.Task.Shorten();

           if(ModelState.IsValid && newTask.Task != "")
           {
               id++;
               newTask.IsActive = true;
               Tasklist.Add(newTask.Task);
               newTask.Id = id;
               db.TaskTables.Add(newTask);
               db.SaveChanges();
           }

           return RedirectToAction("Index");
        }
    }
}
