class CandidateMailer < ApplicationMailer
  default from: 'notifications@recr.ittalent.ee'
 
  def send_candidate(candidate, address)
    @address = address
    @candidate = candidate
    attachments['cv.pdf'] = File.read(@candidate.resume.path)
    mail(to: address, subject: subject(@candidate))
  end
  
  private

  def subject(candidate)
    "#{candidate.name} - #{languages(candidate)} Developer (#{vacancies(candidate)})"
  end

  def vacancies(candidate)
    candidate.vacancies.map{|v| v.company.name}.join("/").to_s
  end

  def languages(candidate)
    candidate.languages.map{|l| l.name}.join('/').to_s
  end
end
