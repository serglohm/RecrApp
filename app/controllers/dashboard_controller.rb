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

    @incompleted_offers = current_user.assignments.hired.incompleted

    if current_user.has_role? :head
      @placements_this_month = Candidate.select(:id, :name)
      @overall_invoices = Assignment.accepted.select(:id, :start_date, :salary)
                                            .group_by_month{ |offer| offer.start_date }
                                            .map{ |month, offers| [month, offers.sum(&:salary)] }
    else
      @income_by_month = current_user.calculate_income_by_month
      @placements_this_month = current_user.candidates
    end
    @sorted_placements = @placements_this_month.starting_this_month
                                               .sort_by{ |a| a.assignments.accepted.first.start_date }
  end
end
