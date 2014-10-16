// $(function() {
//   $('.add-todo').on('submit', function() {
//     event.preventDefault();
//
//     var data = $('.add-todo').serialize();
//     var body = $('.add-todo input').val();
//
//     $.ajax({
//       url: '/todos',
//       type: 'POST',
//       data: data,
//       success: function() {
//         var $listItem = $('<li>').addClass('todo');
//         var $label = $('<label>')
//           .addClass('label label--checkbox')
//           .text(body);
//         var $input = $('<input>')
//           .addClass('checkbox')
//           .attr('type', 'checkbox');
//
//         $label.prepend($input);
//         $listItem.append($label);
//         $('.todo-list').prepend($listItem);
//       }
//     });
//   });
// });

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
