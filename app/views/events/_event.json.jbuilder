json.extract! event, :id, :name, :scheduled_on, :assignment_id, :created_at, :updated_at
json.url event_url(event, format: :json)
