module CandidatesHelper
  def ownership(candidate)
    "#{shorten_name(candidate.user.name)} until #{(candidate.created_at + 1.year).to_date}"
  end

  def assignment_label(obj)
    "#{obj.vacancy.name} at #{obj.vacancy.company.name}, last updated at #{obj.updated_at.to_date} "
  end

  def cv_link_to(obj)
    link_to File.basename(obj.resume.url), cv_path(obj)
  end

  def show_if_present(header, attribute)
    if attribute.present?
      content_tag :p do
        concat(content_tag(:strong, header) + " " + attribute.to_s)
      end
    end
  end

  private

  def shorten_name(name)
    name.split(" ").map{|n| n.first}.join
  end

  def cv_path(obj)
    "/uploads/candidate/resume/#{obj.id}/#{File.basename(obj.resume.url)}"
  end
end
