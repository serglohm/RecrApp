class Candidate < ApplicationRecord
  include PgSearch
  after_save :reindex
  after_touch :set_status

  multisearchable against: [:name, :description, :skype, :email]

  belongs_to :user, counter_cache: true
  belongs_to :source, counter_cache: true

  enum status: [:in_progress, :hired, :rejected, :withdrawn, :draft, :offers_rejected]

  mount_uploader :resume, ResumeUploader

  has_many :skill_abilities, dependent: :destroy
  has_many :skills, through: :skill_abilities

  has_many :assignments, dependent: :destroy
  has_many :vacancies, through: :assignments
  has_many :events, through: :assignments
  has_many :comments

  accepts_nested_attributes_for :assignments, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true

  with_options presence: true do
    validates :name, uniqueness: true
    validates :email
    validates :country
  end

  scope :by_user, -> user_id { where("user_id = ?", user_id) }
  scope :by_status, -> status { where("status = ?", status) }
  scope :by_date, -> start_date, end_date { where("candidates.created_at >= ? AND candidates.created_at <= ?", start_date, end_date ) }
  scope :starting_this_month, -> { joins(:assignments).where("assignments.start_date > ? AND assignments.start_date < ?", Time.now.beginning_of_month, Time.now.end_of_month) }

  def get_offer
    self.assignments.find_by(hired: true)
  end

  private

  def reindex
    PgSearch::Multisearch.rebuild(Candidate)
  end

  def set_status
    if self.assignments.all?(&:rejected?)
      rejected!
    elsif self.assignments.any?(&:hired?)
      hired!
    elsif self.assignments.all?(&:withdrawn?)
      withdrawn!
    elsif self.assignments.all?(&:offer_rejected)
      offers_rejected!
    end
  end
end

