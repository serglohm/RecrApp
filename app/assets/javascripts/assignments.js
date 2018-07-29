$(document).on("turbolinks:load", function() {
  $('.status_field').on('change', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).closest('form').attr("action"),
      headers: {
        Accept : "text/javascript; charset=utf-8",
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
      },
      method: 'PATCH',
      data: {
        assignment: {
          status: $(this).children().children().children().closest('input').val()
        }
      }
    });
  });
});
