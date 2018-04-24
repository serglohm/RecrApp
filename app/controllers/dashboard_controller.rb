class DashboardController < ApplicationController
  def index
    @last_candidates = current_user.candidates
                                   .where(status: :in_progress)
                                   .order(updated_at: :desc)
                                   .last(10)
    @upcoming_events = Event.order(scheduled_on: :asc)
  end
end
