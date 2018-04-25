module DashboardHelper
  def event_name(event)
    event_assignment = event.assignment
    candidate_name = event_assignment.candidate.name
    vacancy_name = event_assignment.vacancy.name
    company_name = event_assignment.vacancy.company.name
    "#{event.name} (#{candidate_name}, #{vacancy_name} at #{company_name})"
  end
end
