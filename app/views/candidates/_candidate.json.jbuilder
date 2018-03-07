json.extract! candidate, :id, :name, :age, :skills, :status, :country, :education, :experience, :expected_salary, :marital_status, :user_id, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
