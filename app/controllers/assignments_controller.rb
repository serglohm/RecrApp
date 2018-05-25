class AssignmentsController < ApplicationController
  before_action :set_assignment, except: :destroy
  before_action :set_candidate, except: :destroy
  after_action :touch_candidate, only: [:reset_status,
                                        :set_hired,
                                        :set_rejected,
                                        :set_withdrawn,
                                        :set_offer_rejected]

  def destroy
    @assignment = Assignment.find(params[:id])
    @candidate = @assignment.candidate
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to @candidate, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def hire_modal
    respond_to do |format|
      format.js
    end
  end

  def reject_modal
    respond_to do |format|
      format.js
    end
  end

  def withdrawn_modal
    respond_to do |format|
      format.js
    end
  end

  def offer_rejected_modal
    respond_to do |format|
      format.js
    end
  end

  def reset_status
    @assignment.reset_status
    redirect_to @assignment.candidate
  end

  def set_hired
    @assignment.to_hire(params[:salary])
    redirect_to @assignment.candidate
  end

  def set_rejected
    @assignment.to_reject(params[:reason])
    redirect_to @assignment.candidate
  end

  def set_withdrawn
    @assignment.to_withdrawn(params[:reason])
    redirect_to @assignment.candidate
  end

  def set_offer_rejected
    @assignment.to_offer_rejected(params[:reason])
    redirect_to @assignment.candidate
  end

  private

  def touch_candidate
    @candidate.touch
  end

  def set_candidate
    @candidate = @assignment.candidate
  end

  def set_assignment
    @assignment = Assignment.find(params[:assignment_id])
  end
end


