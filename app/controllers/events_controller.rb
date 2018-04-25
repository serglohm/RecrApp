class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :set_done, :set_cancelled]

  # GET /events
  # GET /events.json
  def index
    @events = Event.order(name: :asc)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json

  def create
    @event = Event.new(event_params)
    @event.update_attributes(status: :active)
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        format.js
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, error: 'Event was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def set_done
    @event.update_attributes(status: :done)
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Event has been done!' }
    end
  end

  def set_cancelled
    @event.update_attributes(status: :cancelled)
    respond_to do |format|
      format.html { redirect_to dashboard_path, alert: 'Event has been cancelled' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :scheduled_on, :assignment_id)
    end
end
