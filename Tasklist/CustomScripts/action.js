// Generated by CoffeeScript 1.10.0
(function() {
  modules.action = {
    add: {
      submit: function(event) {
        var input;
        event.preventDefault();
        input = $('#Task').val().shorten();
        if (input && input.toLegal().length) {
          input = input.toLegal();
          $('table').append("<tr class=\"1\"><td><input type='checkbox' class=\"checkbox\" autocomplete=\"off\"/></td><td><span class=\"task\">" + input + "</span></td><td>" + modules.userName + "</td><td>" + ((eval($('form').serializeArray()[2].value)).toStatus()) + "</td><td><button class=\"remove btn btn-default btn-sm\">X</button></td></tr>");
          console.log(input.length);
          modules.ajax.add(input);
          return $('#Task').val('');
        } else {
          return alert("Error! Invalid task!");
        }
      }
    },
    change: {
      submit: function(event) {
        var changedTask;
        event.preventDefault();
        changedTask = {
          newTask: $(this).serializeArray()[0].value.shorten().toLegal(),
          id: $(this).parent().parent().parent().data("id")
        };
        if (changedTask.newTask) {
          console.log(changedTask.newTask);
          changedTask.newTask = changedTask.newTask;
          $(this).parent().html("" + changedTask.newTask);
          return modules.ajax.change(changedTask);
        } else if (confirm('Are you sure you want to remove this task?')) {
          modules.ajax.remove(changedTask.id);
          return $(this).parent().parent().parent().remove();
        }
      },
      dblclick: function(event) {
        var html, value;
        event.preventDefault();
        value = $(this).html();
        html = "<form class=\"form-inline\" autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"" + value + "\" autofocus class=\"form-control\"/></form>";
        $(this).html(html);
        $(this).children('input').first().focus();
        return $('#changing').on('submit', modules.action.change.submit);
      }
    },
    remove: {
      click: function() {
        var tr;
        tr = $(this).parent().parent();
        modules.ajax.remove(parseInt(tr.data('id')));
        return tr.remove();
      }
    },
    check: function() {
      var tr;
      tr = $(this).parent().parent();
      if (parseInt(tr.attr('class')) === 1) {
        tr.removeClass('1');
        tr.addClass('0');
      } else {
        tr.removeClass('0');
        tr.addClass('1');
      }
      modules.action.select();
      return modules.ajax.changeStatus(parseInt(tr.data('id')));
    },
    select: (function(_this) {
      return function() {
        return modules.action.selectedOptions[$('select').val()]();
      };
    })(this),
    selectedOptions: {
      all: function() {
        return $('.1, .0').show();
      },
      active: function() {
        $('.0').hide();
        return $('.1').show();
      },
      done: function() {
        $('.1').hide();
        return $('.0').show();
      }
    }
  };

}).call(this);
