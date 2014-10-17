$(function() {
  $('.add-todo').on('submit', function(event) {
    event.preventDefault();

    var data = $('.add-todo').serialize();
    var body = $('.add-todo input').val();
    $('.add-todo input').val("");

    $.ajax({
      url: '/todos',
      type: 'POST',
      data: data,
      success: function(json) {
        var $category = json.id;
        var $options = [{category: "phone", id: 1},
                        {category: "errands", id: 4}];
        console.log($options);
        var $target = $('#' + $category).children('.todo-list');
        var $listItem = $('<li>').addClass('todo');
        var $label = $('<label>')
          .addClass('label label--checkbox')
          .text(body);
        var $checkbox = $('<input>')
          .addClass('checkbox')
          .attr('type', 'checkbox');
        var $selectWrapper = $('<form>')
          .addClass('recategorize')
          .attr('method', 'post');
        var $selectBox = $('<select name="context">')
          .addClass('change_cat');
        var $submit = $('<input>')
          .attr('type', 'submit')
          .val('submit');

        $.each($options, function(i, option) {
          var $value = $("<option value=\""+ option.id +"\">" + option.category +"</option>");
          $selectBox.append($value);
        });

        $selectWrapper.append($selectBox);
        $selectWrapper.append($submit);
        $label.prepend($checkbox);
        $listItem.append($label);
        $listItem.append($selectWrapper);
        $target.prepend($listItem);

      }
    });
  });
});

$(function() {
  $('.checkbox').click(function () {
    var id = $(this).attr('id');
    console.log(this);
    if ($(this).hasClass('checkbox--checked')) {
      var checked = "unchecked";
    } else {
      var checked = "checked";
    }
    var data = {'checked': checked, 'id': id};

    $.ajax({
      url: '/todos',
      type: 'PATCH',
      data: data,
      context: this,
      success: function() {
        $(this).toggleClass('checkbox--checked');
        var todo = $(this).parent().parent();
        $(todo).toggleClass('todo--complete');
      }
    });
  });
});
