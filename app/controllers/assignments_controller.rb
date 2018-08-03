class AssignmentsController < ApplicationController
  before_action :set_assignment, except: [:destroy, :edit, :update]
  before_action :set_candidate, except: [:destroy, :edit, :update]
  after_action :touch_candidate, only: [:reset_status,
                                        :set_hired,
                                        :set_rejected,
                                        :set_withdrawn,
                                        :set_offer_rejected,
                                        :set_invoiced]


  def edit
    @assignment = Assignment.find(params[:id])
    @candidate = @assignment.candidate
  end

  def update
    @assignment = Assignment.find(params[:id])
    @candidate = @assignment.candidate
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.json { render :show, status: :ok, location: @candidate }
        format.js { render layout: false }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @candidate = @assignment.candidate
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to @candidate, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reset_status
    @assignment.reset_status
  end

  def set_hired
    @assignment.to_hire(params[:salary], params[:start_date])
  end

  def set_invoiced
    @assignment.to_invoiced
  end

  def set_rejected
    @assignment.to_reject(params[:reason])
  end

  def set_withdrawn
    @assignment.to_withdrawn(params[:reason])
  end

  def set_offer_rejected
    @assignment.to_offer_rejected(params[:reason])
  end

  private

  def assignment_params
    params.require(:assignment).permit(:candidate_id, :vacancy_id, :status,
                                       :rejected, :reject_reason, :withdrawn,
                                       :withdrawn_reason, :hired, :salary,
                                       :start_date, :offer_rejected, :offer_rejected_reason, :invoiced)
  end

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


