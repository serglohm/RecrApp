class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :source

  enum status: [:in_progress, :hired, :rejected, :withdrawn, :preparation]
  mount_uploader :resume, ResumeUploader
  has_many :skill_abilities
  has_many :skills, through: :skill_abilities

  has_many :assignments
  has_many :vacancies, through: :assignments

  accepts_nested_attributes_for :assignments
end
