$(document).on("turbolinks:load", function() {
  $('#datetimepicker').datetimepicker({
    viewMode: 'years'
  });

  $('#show-modal-button').on('click', function(){
    $('.event-modal').modal();
  })
});
