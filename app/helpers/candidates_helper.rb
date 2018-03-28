module CandidatesHelper
  def ownership(candidate)
    "#{candidate.user.name} until #{(candidate.created_at + 1.year).to_date}"
  end

  def assignment_label(obj)
    "#{obj.vacancy.name} at #{obj.vacancy.company.name}, last updated at #{obj.updated_at.to_date} "
  end

  def cv_link_to(obj)
    link_to File.basename(obj.resume.url), cv_path(obj)
  end

  private

  def cv_path(obj)
    "/uploads/candidate/resume/#{obj.id}/#{File.basename(obj.resume.url)}"
  end
end
