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
        private static TasksEntities db = new TasksEntities(); 
        // public static List<string> Tasks = new List<string>();

        public ActionResult Index()
        {
            var Tasklist = (from x in db.TaskTables
                           select x.Task).ToList<string>();

            ViewBag.Tasks = Tasklist;
            return View();
        }

        public ActionResult AddTask()
        {
            var form = Request.Form;

            TaskTable newTask = new TaskTable();

            newTask.Task = (@form["task"]).Shorten();

            if (newTask.Task != "")
                db.TaskTables.Add(newTask);

            return Redirect("Index");
        }
    }

    public static class StringExtensions
    {
        public static string Shorten(this string entered)
        {
            if (entered == null)
                return "";

            string[] wordsArray= entered.Split(' ');

            var shorten = wordsArray[0];
            for (int i = 1, length = wordsArray.Length; i < length; i++)
                entered += " " + wordsArray[i];

            return entered;
        }
    }
}
