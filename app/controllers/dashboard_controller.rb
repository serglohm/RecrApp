class DashboardController < ApplicationController
  def index
    @last_candidates = Candidate.order(updated_at: :desc).last(10)
  end
end
