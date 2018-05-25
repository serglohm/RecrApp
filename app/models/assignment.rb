class Assignment < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy
  has_many :events, dependent: :destroy
  scope :active, -> { where(hired: false, rejected: false, withdrawn: false) }

  def to_hire(salary)
    _reset_status
    update!(hired: true, salary: salary, finish_date: Date.today)
  end

  def to_reject(reason)
    _reset_status
    update!(rejected: true, reject_reason: reason, finish_date: Date.today)
  end

  def to_withdrawn(reason)
    _reset_status
    update!(withdrawn: true, withdrawn_reason: reason, finish_date: Date.today)
  end

  def reset_status
    _reset_status
    save!
  end

  private

  def _reset_status
    self.hired = false
    self.rejected = false
    self.withdrawn = false
    self.finish_date = nil
    self.salary = nil
    self.reject_reason = nil
    self.withdrawn_reason = nil
  end
end
