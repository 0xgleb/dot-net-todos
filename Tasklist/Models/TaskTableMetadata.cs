using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Tasklist.Models
{
    [MetadataType(typeof(TaskTableMetadata))]
    public partial class TaskTable
    {
        class TaskTableMetadata
        {
            [Required(ErrorMessage="Enter a task!")]
            public string Task {get; set;}
        }
    }
}