require 'rails_helper'

RSpec.describe "vacancies/index", type: :view do
  before(:each) do
    assign(:vacancies, [
      Vacancy.create!(),
      Vacancy.create!()
    ])
  end

  it "renders a list of vacancies" do
    render
  end
end
