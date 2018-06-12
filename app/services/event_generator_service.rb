class EventGeneratorService
  def initialize(params)
    @name = params[:name]
    @scheduled_on = params[:scheduled_on]
    @assignment_id = params[:assignment_id]
  end

  def perform
    Event.create!(name: @name, scheduled_on: @scheduled_on, assignment_id: @assignment_id, status: "active")
  end
end
