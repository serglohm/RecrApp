class Company < ApplicationRecord
  has_many :vacancies
  has_many :candidates, through: :vacancies
  has_many :assignments, through: :vacancies

  validates :name, presence: true, uniqueness: true

  enum pay_type: [:gross_salary, :rate, :half_gross_salary]

  def get_multiplier
    if self.rate?
      multiplier = (self.rate/100).to_f
    elsif self.half_gross_salary?
      multiplier = 1/24.0
    elsif self.gross_salary?
      multiplier = 1/12.0
    end
  end

  def get_rejects
    self.assignments.rejected
  end

  def calculate_shares
    total = assignments.finished.pluck(:id).count.to_f
    if total > 0
      hired = assignments.accepted.pluck(:id).count.to_f
      rejected_share = assignments.rejected.pluck(:id).count / total * 100
      withdrawn_share = assignments.withdrawn.pluck(:id).count / total  * 100
      offer_rejected_share = assignments.offer_rejected.pluck(:id).count / total  * 100
      hired_share = assignments.hired.pluck(:id).count / total  * 100
      avg_income = get_total_income / hired
      json_shares = {
                      rejected: rejected_share.round(2),
                      withdrawn: withdrawn_share.round(2),
                      offer_rejected: offer_rejected_share.round(2),
                      hired: hired_share.round(2),
                      avg_income: avg_income.round(2),
                      total: total
                     }
    end
  end

  def get_total_income
    self.assignments.accepted.sum(&:calculate_invoice_sum)
  end

end
