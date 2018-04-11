class CandidateMailer < ApplicationMailer
  default from: 'notifications@recr.ittalent.ee'

  def send_candidate(candidate, address)
    @address = address
    @candidate = candidate
    attachments["#{cv_name(@candidate)}CV.pdf"] = File.read(@candidate.resume.path)
    mail(to: address, subject: subject(@candidate))
  end

  private

  def subject(candidate)
    "#{candidate.name} - #{skills(candidate)} (#{vacancies(candidate)})"
  end

  def vacancies(candidate)
    candidate.vacancies.map{|v| v.company.name}.join("/").to_s
  end

  def skills(candidate)
    candidate.skills.map{|l| l.name}.join('/').to_s
  end

  def cv_name(candidate)
    @candidate.name.split(" ").join()
  end
end
