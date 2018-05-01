class AssignmentsController < ApplicationController
  before_action :set_assignment, except: :destroy
  before_action :set_candidate
  def destroy
    @assignment = Assignment.find(params[:id])
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

  def set_hired
    @assignment.hire(params[:salary])
    redirect_to @assignment.candidate
  end

  def set_rejected
    @assignment.reject(params[:reason])
    redirect_to @assignment.candidate
  end

  def set_withdrawn
    @assignment.withdrawn(params[:reason])
    redirect_to @assignment.candidate
  end

  private

  def set_candidate
    @candidate = @assignment.candidate
  end

  def set_assignment
    @assignment = Assignment.find(params[:assignment_id])
  end
end
