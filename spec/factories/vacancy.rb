FactoryBot.define do
  factory :cool_vacancy do
    name 'Frontend Developer'
    salary_min '2500'
    salary_max '4000'
    company_id Company.take.id
  end
end
