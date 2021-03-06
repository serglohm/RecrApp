var statusButtonId, myCustomModalId;

function showProperModal(modal_id, statusButtonId) {
    myCustomModalId = modal_id + '-' + statusButtonId;
    $(myCustomModalId).modal();
}

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

  $('.hire_date').datetimepicker({
    format: "L"
  });

  $('.hire_button').on('click', function(){
    showProperModal('#hireModal', $(this).data('assignmentId'));
  });

  $('.reject_button').on('click', function(){
    showProperModal('#rejectModal', $(this).data('assignmentId'));
  });

  $('.withdrawn_button').on('click', function(){
    showProperModal('#withdrawnModal', $(this).data('assignmentId'));
  });

  $('.offer_reject_button').on('click', function(){
    showProperModal('#offerRejectModal', $(this).data('assignmentId'));
  });

  $('.status_submit').on('click', function() {
    $(myCustomModalId).modal('hide');
    console.log(myCustomModalId+" hidden");
  });
});
