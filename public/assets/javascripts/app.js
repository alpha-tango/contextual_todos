$('.change_cat').change(function() {
  var selectedValue = $(this).val();

  switch(selectedValue) {
    default:
      alert("This is the default!");
      break;
  }
});

// $(function () {
//   $('.add-todo').on('submit', function(event) {
//     event.preventDefault();
//
//     var data = $('.add-todo').serialize()
//     var body = $('.add-todo input').val();
//
// //Serialize form input values
//     $.ajax({
//       url: '/todos',
//       type: 'POST',
//       data: data,
//       success: function () {
//         var $listItem = $('<li>').addClass('todo'),
//             $label = $('<label>');
//         .addClass('label label--checkbox')
//         .text(body);
//         var $input = $('<input>')
//         .addClass('checkbox')
//         .attr('type', 'checkbox');
//
//           $label.append($input);
//           $listItem.append($label);
//           $('.todo-list').append($listItem);
//       }
//     });
//   });
// });
