class User < ApplicationRecord
  rolify
  require 'telegraph-ruby'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :candidates
  has_many :assignments, through: :candidates
  has_many :events, through: :candidates
  has_many :chats
  has_many :comments

  scope :active, -> { where(active: true) }
  scope :disabled, -> { where(active: false) }

  enum pay_type: [:fixed_rate, :share]

  TAX_RATE = 0.5847

  def active?
    self.active
  end

  def disabled?
    !self.active
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    !active? ? super : "You're not allowed to log in"
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def calculate_income_by_month(user)
    if self.fixed_rate?
      offers = assignments.accepted.group_by_month(:start_date).count
      offers.map do |month, value|
        [
          month,
          value * rate_per_candidate
        ]
      end
    elsif self.share?
      offers = user.assignments.accepted.group_by_month{|offer| offer.start_date}.map{|month, offers| [month, User.calculate_income(user, offers)]}
    end
  end

  def create_telegraph_account
    telegraph = Telegraph.new
    account = telegraph.createAccount(short_name: short_name,
                                      author_name: author_name,
                                      author_url: author_url)
    self.access_token = account['access_token']
    self.auth_url = account['auth_url']
    save!
  end

  def delete_telegraph_account
    telegraph = Telegraph.new
    telegraph.revokeAccessToken(access_token)
    self.access_token = nil
    self.auth_url = nil
    save!
  end

  def self.calculate_income(user, offers)
    rate = user.bonus_salary_rate.to_f / 100
    offers_sum = offers.sum(&:calculate_invoice_sum)
    threshold = user.salary_threshold
    rest = offers_sum - threshold
    rest_multiplied_by_rate = (rest * rate).to_f
    salary = user.base_salary
    income = (rest_multiplied_by_rate + salary) * TAX_RATE
    income.round(2)
  end
end
