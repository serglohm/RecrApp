class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :source
  enum status: [:in_progress, :hired, :rejected, :withdrawn]
  mount_uploader :resume, ResumeUploader
  has_many :lang_skills
  has_many :languages, through: :lang_skills
end
