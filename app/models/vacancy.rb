class Vacancy < ApplicationRecord
  require 'telegraph-ruby'
  belongs_to :company

  has_many :skill_requirements, dependent: :destroy
  has_many :skills, through: :skill_requirements

  has_many :assignments, dependent: :destroy
  has_many :candidates, through: :assignments

  validates :name, presence: true,
                   uniqueness: { scope: :company,
                                 message: "should be unique inside a company" }
  validates :salary_min, presence: true
  validates :salary_max, presence: true
  validate :salary_max_greater_than_salary_min

  def salary_max_greater_than_salary_min
    if salary_min > salary_max
      errors.add(:salary_min, "Minimum salary should be less or equal to Maximum salary")
    end
  end

  def create_telegraph_page(user)
    telegraph = Telegraph.new
    page = telegraph.createPage(access_token: user.access_token, title: name, content: nil)
    self.telegraph_link_ru = page["url"]
    save!
  end
end
