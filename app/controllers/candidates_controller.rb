class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update,
                                       :destroy, :download, :send_resume]

  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.all
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    @candidate = current_user.candidates.new
  end

  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates
  # POST /candidates.json
  def create
    @candidate = current_user.candidates.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    send_file @candidate.resume.path, x_sendfile: true
  end

  def send_resume
    @address = current_user.email
    CandidateMailer.send_candidate(@candidate, @address).deliver_now
    flash[:notice] = "Resume has been sent."
    redirect_to candidate_path(@candidate)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:name, :age, :description, :status, :country,
                                        :spoken_languages,:education, :resume,
                                        :experience, :expected_salary,:marital_status, :github,
                                        :linked_in, :skype, :email, :availability,
                                        :source_id, assignments_attributes:[:id, :vacancy_id, :status],
                                        skill_ids:[], vacancy_ids:[])
    end
end
