module CandidatesHelper
  def ownership(candidate)
    "#{candidate.user.name} until #{(candidate.created_at + 1.year).to_date}"
  end
end
