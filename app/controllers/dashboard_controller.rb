class DashboardController < ApplicationController
  def index
    @last_candidates = current_user.candidates
                                   .where.not(status: :hired)
                                   .order(updated_at: :desc)
                                   .last(10)
  end
end
