// Generated by CoffeeScript 1.10.0
(function() {
  var action, ajax;

  String.Prototype.shorten = function() {
    var i, j, ref, shorten, words;
    words = this.split(' ');
    shorten = words[0];
    for (i = j = 1, ref = words.length; 1 <= ref ? j < ref : j > ref; i = 1 <= ref ? ++j : --j) {
      shorten += words[i];
    }
    return shorten;
  };

  ajax = {
    add: function(input) {
      return $.ajax('/Home/Add', {
        type: "POST",
        data: $('form').serialize(),
        beforeSend: function() {},
        success: function(response) {
          response = parseInt(response);
          console.log(response);
          if (response !== -1) {
            return $('ul').append("<li data-id='" + response + "'><input type='checkbox' /><span>" + input + "</span>  <button>Remove</button></li>");
          } else {
            return alert("Error!");
          }
        },
        timeout: 3000,
        error: function(request, errorType, errorMessage) {
          return console.log("Error " + errorType + " with message: " + errorMessage + " [clientside]");
        },
        complete: function() {
          return console.log("Loading finished! [clientside]");
        }
      });
    },
    change: function(changedTask) {
      return $.ajax('/Home/Change', {
        type: "POST",
        data: changedTask,
        beforeSend: function() {},
        success: function(response) {
          return console.log(response);

          /*response = parseInt response
          console.log response
          if response != -1
            console.log @
            $(@).parent().html "#{$(@).serializeArray()[0]}"
          else
            alert "Error!"
           */
        },
        timeout: 3000,
        error: function(request, errorType, errorMessage) {
          return console.log("Error " + errorType + " with message: " + errorMessage + " [clientside]");
        },
        complete: function() {
          return console.log("Loading finished! [clientside]");
        }
      });
    },
    remove: function(id) {
      return console.log('');
    }
  };

  action = {
    add: {
      submit: function(event) {
        var input;
        event.preventDefault();
        input = $('.editor-field input').val();
        if (input) {
          ajax.add(input.shorten);
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
          newTask: $(this).serializeArray()[0].value,
          id: $(this).parent().parent().data("id")
        };
        return ajax.change(changedTask);
      },
      dblclick: function(event) {
        var html, value;
        event.preventDefault();
        value = $(this).html();
        html = "<form autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"" + value + "\" autofocus/></form>";
        $(this).html(html);
        $(this).children('input').first().focus();
        console.log('ID: ' + $(this).parent().data("id"));
        return $('#changing').on('submit', action.change.submit);
      },
      remove: {
        click: function() {}
      }
    }
  };

  $(document).on('ready', function() {
    $('#Task').focus();
    $('form').attr('autocomplete', 'off');
    $('form').first().on('submit', action.add.submit);
    return $('li span').on('dblclick', action.change.dblclick);
  });

}).call(this);