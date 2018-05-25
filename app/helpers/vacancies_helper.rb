module VacanciesHelper
  def check_completion(field)
    if field.present?
      content_tag(:td, fa_icon('check'))
    else
      content_tag(:td, fa_icon('times'), class:'table-danger')
    end
  end

  def candidates_in_progress(company)
    company.candidates.in_progress.count
  end
end
