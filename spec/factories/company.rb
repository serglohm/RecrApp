FactoryBot.define do
  factory :gross_company do
    email 'Gross Company'
  end

  factory :half_gross_company do
    email 'Half Gross Company'
    pay_type 1
  end

  factory :rate_company do
    email 'Rate Company'
    pay_type 2
    rate 10.0
  end
end
