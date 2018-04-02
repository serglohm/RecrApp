class User < ApplicationRecord
  rolify
  require 'telegraph-ruby'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :candidates

  def create_telegraph_account
    telegraph = Telegraph.new
    account = telegraph.createAccount(short_name: short_name,
                                      author_name: author_name,
                                      author_url: author_url)
    self.access_token = account['access_token']
    self.auth_url = account['auth_url']
    save!
  end
end
