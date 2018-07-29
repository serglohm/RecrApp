require 'rails_helper'

RSpec.describe "vacancies/edit", type: :view do
  before(:each) do
    @vacancy = assign(:vacancy, Vacancy.create!())
  end

  it "renders the edit vacancy form" do
    render

    assert_select "form[action=?][method=?]", vacancy_path(@vacancy), "post" do
    end
  end
end
