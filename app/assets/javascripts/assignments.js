var statusButtonId, myCustomModalId;

$(document).on("turbolinks:load", function() {

  function showProperModal(modal_id, this_modal) {
    statusButtonId = $(this_modal).data('assignmentId');
    myCustomModalId = modal_id + '-' + statusButtonId;
    $(myCustomModalId).modal();
  }

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
    showProperModal('#hireModal', this);
  });

  $('.reject_button').on('click', function(){
    showProperModal('#rejectModal', this);
  });

  $('.withdrawn_button').on('click', function(){
    showProperModal('#withdrawnModal', this);
  });

  $('.offer_reject_button').on('click', function(){
    showProperModal('#offerRejectModal', this);
  });

  $('.status_submit').on('click', function() {
    $(myCustomModalId).modal('hide');
    console.log(myCustomModalId+" hidden");
  });
});
