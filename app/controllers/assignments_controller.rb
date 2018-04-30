class AssignmentsController < ApplicationController
  def destroy
    @assignment = Assignment.find(params[:id])
    @candidate = @assignment.candidate
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to @candidate, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
