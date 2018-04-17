class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :source

  enum status: [:in_progress, :hired, :rejected, :withdrawn, :draft]
  mount_uploader :resume, ResumeUploader
  has_many :skill_abilities, dependent: :destroy
  has_many :skills, through: :skill_abilities

  has_many :assignments, dependent: :destroy
  has_many :vacancies, through: :assignments

  accepts_nested_attributes_for :assignments, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :country, presence: true
end
