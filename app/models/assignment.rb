class Assignment < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy
  has_many :events, dependent: :destroy


  def hire(salary)
    reset_status
    self.hired = true
    self.salary = salary
    self.finish_date = Date.today
    save!
  end

  def reject(reason)
    reset_status
    self.rejected = true
    self.reject_reason = reason
    self.finish_date = Date.today
    save!
  end

  def withdrawn(reason)
    reset_status
    self.withdrawn = true
    self.withdrawn_reason = reason
    self.finish_date = Date.today
    save!
  end

  def reset_status
    self.hired = false
    self.rejected = false
    self.withdrawn = false
    self.finish_date = nil
    self.salary = nil
    self.reject_reason = nil
    self.withdrawn_reason = nil
    save!
  end
end
