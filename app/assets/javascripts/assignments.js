$(document).on("turbolinks:load", function() {
  $('.status_field').on('change', function() {
    console.log();
    $.ajax({
      url: $(this).closest('form').attr("action"),
      headers: {
        Accept : "text/javascript; charset=utf-8",
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
      },
      method: 'PATCH',
      data: {
        assignment: {
          status: $(this).children().closest('input').val()
        }
      }
    });
  });
});
