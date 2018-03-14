class Candidate < ApplicationRecord
  belongs_to :user
  has_many :languages, as: :assignable
  mount_uploader :resume, ResumeUploader
end
