// Generated by CoffeeScript 1.10.0
(function() {
  modules.action = {
    add: {
      submit: function(event) {
        var input;
        event.preventDefault();
        input = $('.editor-field input').val().shorten();
        if (input) {
          $('ul').append("<li class=\"1\"><input type='checkbox' class=\"checkbox\" autocomplete=\"off\"/><span>" + input + "</span>  <button>Remove</button></li>");
          modules.ajax.add(input);
          return $('.editor-field input').val('');
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
          newTask: $(this).serializeArray()[0].value.shorten(),
          id: $(this).parent().parent().data("id")
        };
        if (changedTask.newTask) {
          $(this).parent().html("" + changedTask.newTask);
          return modules.ajax.change(changedTask);
        } else if (confirm('Are you sure you want to remove this task?')) {
          return modules.ajax.remove(changedTask.id);
        }
      },
      dblclick: function(event) {
        var html, value;
        event.preventDefault();
        value = $(this).html();
        html = "<form autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"" + value + "\" autofocus/></form>";
        $(this).html(html);
        $(this).children('input').first().focus();
        return $('#changing').on('submit', modules.action.change.submit);
      }
    },
    remove: {
      click: function() {
        var li;
        if (confirm('Are you sure?')) {
          li = $(this).parent();
          modules.ajax.remove(parseInt(li.data('id')));
          return li.remove();
        }
      }
    },
    check: function() {
      var li;
      li = $(this).parent();
      if (parseInt(li.attr('class')) === 1) {
        li.removeClass('1');
        li.addClass('0');
      } else {
        li.removeClass('0');
        li.addClass('1');
      }
      modules.action.select();
      return modules.ajax.changeStatus(parseInt($(this).parent().data('id')));
    },
    select: (function(_this) {
      return function() {
        return modules.action.selectedOptions[$('select').val()]();
      };
    })(this),
    selectedOptions: {
      all: function() {
        console.log('all');
        return $('.1, .0').show();
      },
      active: function() {
        console.log('active');
        $('.0').hide();
        return $('.1').show();
      },
      done: function() {
        console.log('done');
        $('.1').hide();
        return $('.0').show();
      }
    }
  };

}).call(this);
