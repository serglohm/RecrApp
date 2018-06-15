class DashboardController < ApplicationController
  def index
    @candidates = current_user.candidates
                              .where(status: :in_progress)
                              .sort_by { |candidate| candidate.assignments.active.in_progress.count }
                              .reverse

    @upcoming_events = current_user.events
                                   .active
                                   .upcoming
                                   .includes(:assignment)
                                   .includes(:vacancy)
                                   .order(scheduled_on: :asc)
  end
end
