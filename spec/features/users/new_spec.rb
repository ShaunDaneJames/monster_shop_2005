require "rails_helper"

describe "as a vistor" do
  describe "user new page" do
    it "has a register link in the nav bar" do
      visit '/merchants'

      expect(page).to have_link('Register')
      click_link 'Register'
      expect(current_path).to eq('/register')
    end

    it "has a form asking for new user details" do
      visit '/register'

      expect(page).to have_field("Name")
      expect(page).to have_field("Street Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Email Address")
      expect(page).to have_field("Password")
      expect(page).to have_field("Confirm Password")
    end

    it "has a form asking for new user details" do
      visit '/register'

      fill_in "Name", with: "Mike Dao"
      fill_in "Street Address", with: "100 Main"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: "80002"
      fill_in "Email Address", with: "mike@gmail"
      fill_in "Password", with: "password"
      fill_in "Confirm Password", with: "password"

      click_button "Submit"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Logged in as Mike Dao.")
    end
  end
end

describe "as a vistor" do
  describe "user new page" do
    it "has a register link in the nav bar" do

      visit '/register'

      fill_in "Name", with: "Mr. Robot"

      click_button "Submit"

      expect(page).to have_content("Please fill in all fields!")
    end
  end
end

describe "as a vistor" do
  describe "user new page" do
    it "has a register link in the nav bar" do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: 80111,
                            email_address: "Todd@example.com",
                            password: "superEasyPZ")
      visit '/register'

      fill_in "Name", with: "Mike Dao"
      fill_in "Street Address", with: "100 Main"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: "80002"
      fill_in "Email Address", with: "Todd@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirm Password", with: "password"

      click_button "Submit"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Please select a unique email!")

    end
  end
end

describe "As a user" do
  describe "once they've registered" do
    it "it keeps the user logged in" do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: 80111,
                            email_address: "George@example.com",
                            password: "superEasyPZ")
      visit("/merchants")
      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Logged in as #{user_2.name}.")
    end
  end
end
