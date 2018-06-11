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

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
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
end
