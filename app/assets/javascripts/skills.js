$(document).on("turbolinks:load", function() {
  var selectizeCallback = null;
  $(".skill-modal").on("hide.bs.modal", function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selectizeCallback = null;
    }
    $("#new_skill").trigger("reset");
    Rails.enableElement($("#skill-submit")[0]);
  });

  $("#new_skill").on("submit", function(e) {
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: function(responce) {
        selectizeCallback({ value: responce.id, text: responce.name });
        selectizeCallback = null;
        $(".skill-modal").modal('toggle');
      }
    });
  });

  $(".selectize-skills").selectize({
    create: function(input, callback) {
      selectizeCallback = callback;
      $(".skill-modal").modal();
      $("#skill_name").val(input);
    }
  });
});
