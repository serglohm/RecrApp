module VacanciesHelper
  def check_tg(link)
    if link.present?
      content_tag(:td, fa_icon('check'))
    else
      content_tag(:td, fa_icon('times'), class:'table-danger')
    end
  end
end
