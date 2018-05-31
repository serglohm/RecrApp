class Assignment < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy
  has_many :events, dependent: :destroy
  has_one :user, through: :candidate
  scope :active, -> { where(hired: false, rejected: false, withdrawn: false) }
  scope :accepted, -> { where(hired: true).where.not(start_date: nil) }

  def to_hire(salary, date_of_start)
    _reset_status
    date = Date.strptime(date_of_start, "%m/%d/%Y")
    update!(hired: true, salary: salary, start_date: date, finish_date: Date.today)
  end

  def to_reject(reason)
    _reset_status
    update!(rejected: true, reject_reason: reason, finish_date: Date.today)
  end

  def to_withdrawn(reason)
    _reset_status
    update!(withdrawn: true, withdrawn_reason: reason, finish_date: Date.today)
  end

  def to_offer_rejected(reason)
    _reset_status
    update!(offer_rejected: true, offer_rejected_reason: reason, finish_date: Date.today)
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
    self.offer_rejected = false
    self.finish_date = nil
    self.start_date = nil
    self.salary = nil
    self.reject_reason = nil
    self.withdrawn_reason = nil
    self.offer_rejected_reason = nil
  end
end
