class CandidatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_candidate, only: [:show, :edit, :update,
                                       :destroy, :download, :send_resume]
  before_action :set_vacancies_and_skills, only: [:new, :create, :update, :edit]
  has_scope :by_user
  has_scope :by_status, default: 0
  # GET /candidates
  # GET /candidates.json
  def index
    if current_user.has_any_role? :admin, :head, :recruiter
      @candidates = apply_scopes(Candidate.includes(:source, :user)).order(created_at: :desc)
    else
      @candidates = current_user.candidates.order(created_at: :desc)
    end
    @users = User.select(:id, :name)
    @statuses = Candidate.statuses.map{ |key, value| [key.humanize, value] }
    respond_to do |format|
      format.html
      format.xlsx { render xlsx: 'export_to_xlsx' }
    end
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
    @admins = User.with_any_role(:admin, :head).delete_if{ |user| user.id == current_user.id }
    @comments = @candidate.comments
    @comment = current_user.comments.new(candidate_id: @candidate.id)
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
    if params[:manager]
      @address = User.find(params[:manager]).email
    else
      @address = current_user.email
    end
    CandidateMailer.send_candidate(@candidate, @address, current_user).deliver_now
    flash[:notice] = "Resume has been sent."
    redirect_to candidate_path(@candidate)
  end

  def export_to_xlsx
    @candidates = current_user.candidates.where(status: :in_progress)
    respond_to do |format|
      format.xlsx
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    def set_vacancies_and_skills
      @vacancies = Vacancy.active.map{|v| ["#{v.name} at #{v.company.name}", v.id]}
      @skills = Skill.all.pluck(:name, :id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:name, :description, :status, :country, :city,
                                        :spoken_languages, :education, :resume,
                                        :experience, :expected_salary, :marital_status,
                                        :github, :linked_in, :skype, :email,
                                        :phone, :availability, :source_id,
                                        assignments_attributes: [:id, :vacancy_id, :status,
                                                                :candidate_id, :salary, :withdrawn_reason,
                                                                :reject_reason, :start_date],
                                        comments_attributes: [:id, :content, :_destroy],
                                        skill_ids:[], vacancy_ids:[])
    end
end
