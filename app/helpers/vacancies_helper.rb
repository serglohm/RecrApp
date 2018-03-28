module VacanciesHelper
  def check_tg(link)
    if link.present?
      fa_icon "check"
    else
      fa_icon "times"
    end
  end
end
