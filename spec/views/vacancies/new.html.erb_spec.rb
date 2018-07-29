require 'rails_helper'

RSpec.describe "vacancies/new", type: :view do
  before(:each) do
    assign(:vacancy, Vacancy.new())
  end

  it "renders new vacancy form" do
    render

    assert_select "form[action=?][method=?]", vacancies_path, "post" do
    end
  end
end
