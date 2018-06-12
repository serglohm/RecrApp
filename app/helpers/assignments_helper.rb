module AssignmentsHelper
  def set_color_to_assignment(obj)
    if obj.hired?
      "alert alert-success"
    elsif obj.rejected?
      "alert alert-danger"
    elsif obj.withdrawn?
      "alert alert-warning"
    elsif obj.offer_rejected?
      "alert alert-warning"
    else
      "alert alert-primary"
    end
  end
end
