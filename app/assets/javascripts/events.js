$(document).on("turbolinks:load", function() {
  $('#datetimepicker').datetimepicker({
    format: "YYYY-MM-DD HH:mm"
  });

  var buttonId = null;

  $(".event-modal").on("hide.bs.modal", function(e) {
    if (buttonId != null) {
      buttonId = null;
    }
    $("#new_event").trigger("reset");
    Rails.enableElement($("#event-submit")[0]);
  });

  $('.show-modal-button').on('click', function(){
    $('.event-modal').modal();
    buttonId = $(this).data('assignmentId');
  });


  $("#new_event").on("submit", function(e) {
    $("#assignment-id").val(buttonId);
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: function(responce) {
        $(".event-modal").modal('toggle');
      },
      error: function(responce){
        console.log(responce);
      }
    });
  });
});
