class Assignment < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy

  has_many :events, dependent: :destroy
  has_one :company, through: :vacancy
  has_one :user, through: :candidate

  scope :in_progress, -> { includes(:candidate).where('candidates.status = ?', 0).references(:candidate) }
  scope :active, -> { where(hired: false, rejected: false, withdrawn: false, offer_rejected: false) }
  scope :finished, -> { where.not(finish_date: nil) }

  scope :hired, -> { where(hired: true) }
  scope :rejected, -> { where(rejected: true) }
  scope :accepted, -> { where(hired: true).where.not(start_date: nil).where.not(salary: nil) }
  scope :invoiced, -> { where(invoiced: true) }
  scope :not_invoiced, -> { where(invoiced: false) }
  scope :incompleted, -> { where(salary: nil).or(where(start_date: nil)) }

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

  def to_invoiced
    if hired?
      update!(invoiced: true)
    end
  end

  def reset_status
    _reset_status
    save!
  end

  def self.generate_follow_ups
    Assignment.active.in_progress.each do |a|
      if a.updated_at < 7.day.ago
        EventGeneratorService.new(name: "Follow up or update status",
                                  scheduled_on: DateTime.now.middle_of_day,
                                  assignment_id: a.id).perform
      end
    end
  end

  def self.generate_invoice_reminders
    Assignment.accepted.not_invoiced.each do |a|
      if Date.today >= a.start_date
        EventGeneratorService.new(name: "Send invoice or set invoiced",
                                  scheduled_on: DateTime.now.middle_of_day,
                                  assignment_id: a.id).perform
      end
    end
  end

  def calculate_invoice_sum
    company = self.company
    sum = (salary * 12 * company.get_multiplier).to_i
  end

  private

  def _reset_status
    self.hired = false
    self.rejected = false
    self.withdrawn = false
    self.offer_rejected = false
    self.invoiced = false
    self.finish_date = nil
    self.start_date = nil
    self.salary = nil
    self.reject_reason = nil
    self.withdrawn_reason = nil
    self.offer_rejected_reason = nil
  end
end
