class ReportsController < ApplicationController
  before_action :verify_admin
  before_action :set_candidates_and_users

  has_scope :by_date, using: %i[start_date end_date]
  has_scope :by_status

  def candidates_by_users
    @grouped_candidates = @candidates.joins(:user).group("users.name")
  end

  def candidates_by_sources
    @grouped_candidates = @candidates.joins(:source).group("sources.name")
  end

  def candidates_by_months
    @accepted_assignments = Assignment.accepted.joins(:user).group_by_month(:start_date)
  end

  private

  def set_candidates_and_users
    @candidates = apply_scopes(Candidate.includes(:source, :user)).order(created_at: :desc)
    @users = User.select(:id, :name)
    @statuses = Candidate.statuses.map{ |key, value| [key.humanize, value] }
  end

  def verify_admin
    redirect_to root_url unless current_user.has_role?(:admin)
  end
end
