require 'rails_helper'

RSpec.describe "chats/index", type: :view do
  before(:each) do
    assign(:chats, [
      Chat.create!(
        :name => "Name",
        :user => nil
      ),
      Chat.create!(
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of chats" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
