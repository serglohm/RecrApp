class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update,
                                       :destroy, :download, :send_resume]
  before_action :set_vacancies_and_skills, only: [:new, :create, :update, :edit]
  has_scope :by_user
  has_scope :by_status
  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = apply_scopes(Candidate).order(created_at: :desc)
    @users = User.select(:id, :name)
    @statuses = Candidate.statuses.map{ |key, value| [key.humanize, value] }
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
    @admins = User.with_role(:admin).where.not(id: current_user.id)
  end

  # GET /candidates/new
  def new
    @candidate = current_user.candidates.new
  end

  # GET /candidates/1/edit
  def edit
    @vacancies = Vacancy.order(:name)
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
    if params[:manager]
      @address = User.find(params[:manager]).email
    else
      @address = current_user.email
    end
    CandidateMailer.send_candidate(@candidate, @address).deliver_now
    flash[:notice] = "Resume has been sent."
    redirect_to candidate_path(@candidate)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    def set_vacancies_and_skills
      @vacancies = Vacancy.order(:name)
      @skills = Skill.order(:name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:name, :description, :status, :country, :city,
                                        :spoken_languages, :education, :resume,
                                        :experience, :expected_salary, :marital_status,
                                        :github, :linked_in, :skype, :email,
                                        :phone, :availability, :source_id,
                                        assignments_attributes:[:_destroy, :id, :vacancy_id, :status, :candidate_id],
                                        skill_ids:[], vacancy_ids:[])
    end
end
