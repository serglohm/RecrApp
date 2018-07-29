require 'rails_helper'

RSpec.describe "vacancies/show", type: :view do
  before(:each) do
    @vacancy = assign(:vacancy, Vacancy.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
