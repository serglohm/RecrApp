module VacanciesHelper
  def check_tg(link)
    if link.present?
      fa_icon "check-circle"
    else
      fa_icon "times-circle"
    end
  end
end
