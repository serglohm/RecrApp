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
    @income_by_month = current_user.calculate_income_by_month(current_user)
    @placements_this_month = current_user.candidates.starting_this_month
  end
end
