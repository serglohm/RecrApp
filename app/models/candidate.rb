class Candidate < ApplicationRecord
  include PgSearch
  after_save :reindex
  after_touch :set_status

  multisearchable against: [:name, :description, :skype, :email]

  belongs_to :user
  belongs_to :source

  enum status: [:in_progress, :hired, :rejected, :withdrawn, :draft, :offers_rejected]

  mount_uploader :resume, ResumeUploader

  has_many :skill_abilities, dependent: :destroy
  has_many :skills, through: :skill_abilities

  has_many :assignments, dependent: :destroy
  has_many :vacancies, through: :assignments
  has_many :events, through: :assignments

  accepts_nested_attributes_for :assignments, allow_destroy: true

  with_options presence: true do
    validates :name, uniqueness: true
    validates :email
    validates :country
  end

  scope :by_user, -> user_id { where("user_id = ?", user_id) }
  scope :by_status, -> status { where("status = ?", status) }

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

