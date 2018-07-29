require 'rails_helper'

feature "User logs in and logs out" do

  # `js: true` spec metadata means this will run using the `:selenium`
  # browser driver configured in spec/support/capybara.rb
  scenario "with correct details", js: true do

    create(:user, email: "someone@example.tld", password: "somepassword")

    visit "/"

    click_button "Log in"
    expect(page).to have_css("h2", text: "Log in")
    expect(current_path).to eq(new_user_session_path)

    login "someone@example.tld", "somepassword"

    expect(page).to have_css("h1", text: "Dashboard")
    expect(current_path).to eq "/"
    expect(page).to have_content "Signed in successfully"

    click_link "Logout"

    expect(current_path).to eq "/users/sign_in"
    expect(page).to have_content "You need to sign in or sign up before continuin"
    expect(page).not_to have_content "Dashboard"

  end

  private

  def login(email, password)
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end

end
