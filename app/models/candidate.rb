class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :source
  enum status: [:in_progress, :hired, :rejected, :withdrawn]
  mount_uploader :resume, ResumeUploader
end
