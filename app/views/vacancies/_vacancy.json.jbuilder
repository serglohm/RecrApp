json.extract! vacancy, :id, :name, :telegraph_link_ru, :telegraph_link_en, :description, :salary_min, :salary_max, :user_id, :created_at, :updated_at
json.url vacancy_url(vacancy, format: :json)
