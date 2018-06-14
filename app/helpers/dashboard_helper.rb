module DashboardHelper
  def event_name(event)
    event_assignment = event.assignment
    candidate = event.candidate
    candidate_name = candidate.name
    vacancy_name = event_assignment.vacancy.name
    company_name = event_assignment.vacancy.company.name
    "#{event.name} (#{link_to(candidate_name, candidate_path(candidate)).html_safe}, #{vacancy_name} at #{company_name})".html_safe
  end
end
