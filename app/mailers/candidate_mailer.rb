class CandidateMailer < ApplicationMailer
  default from: 'notifications@recr.ittalent.ee'

  def send_candidate(candidate, address, user)

    @address = address
    @candidate = candidate
    @user = user
    if candidate.resume.present?
      attachments["#{cv_name(@candidate)}CV.pdf"] = File.read(@candidate.resume.path)
    end
    mail(to: address,
         from: "#{user.name} <notifications@recr.ittalent.ee>",
         subject: subject(@candidate),
         reply_to: user.email)
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
