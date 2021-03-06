require 'rails_helper'


describe 'User Show Page' do
  describe 'As a registered user' do
    it "can see all its profile date minus my password" do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: 80111,
                            email_address: "George@example.com",
                            password: "superEasyPZ")
                            visit "/login"

      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")

      expect(page).to have_content("Name: #{user_2.name}")
      expect(page).to have_content("Street Address: #{user_2.street_address}")
      expect(page).to have_content("City: #{user_2.city}")
      expect(page).to have_content("State: #{user_2.state}")
      expect(page).to have_content("Zip: #{user_2.zip}")
      expect(page).to have_content("Email: #{user_2.email_address}")
      expect(page).to_not have_content(user_2.password)

      expect(page).to have_link('Edit Profile')
    end

    it 'can click the Edit Profile link and see a form to edit data' do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: '80111',
                            email_address: "George@example.com",
                            password: "superEasyPZ")
                            visit "/login"

      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")

      click_link('Edit Profile')

      expect(current_path).to eq('/profile/edit')

      expect(find_field(:name).value).to eq(user_2.name)
      expect(find_field(:street_address).value).to eq(user_2.street_address)
      expect(find_field(:city).value).to eq(user_2.city)
      expect(find_field(:state).value).to eq(user_2.state)
      expect(find_field(:zip).value).to eq(user_2.zip.to_s)
      expect(find_field(:email_address).value).to eq(user_2.email_address)
    end
    it 'can click the Edit Profile link and see a form to edit data' do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: '80111',
                            email_address: "George@example.com",
                            password: "superEasyPZ")
                            visit "/login"

      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")

      click_link('Edit Profile')

      expect(current_path).to eq('/profile/edit')

      expect(find_field(:name).value).to eq(user_2.name)
      fill_in("Street Address", with: "100 Elm Street")
      expect(find_field(:city).value).to eq(user_2.city)
      expect(find_field(:state).value).to eq(user_2.state)
      expect(find_field(:zip).value).to eq(user_2.zip.to_s)
      expect(find_field(:email_address).value).to eq(user_2.email_address)

      fill_in "Password", with: "superEasyPZ"
      fill_in "Confirm Password", with: "superEasyPZ"


      click_button('Submit Changes')

      expect(current_path).to eq('/profile')

      expect(page).to have_content("You have successfully updated your profile")


      expect(page).to have_content("Name: #{user_2.name}")
      expect(page).to have_content("Street Address: 100 Elm Street")
      expect(page).to have_content("City: #{user_2.city}")
      expect(page).to have_content("State: #{user_2.state}")
      expect(page).to have_content("Zip: #{user_2.zip}")
      expect(page).to have_content("Email: #{user_2.email_address}")
      expect(page).to_not have_content(user_2.password)
    end

    it "can visit profile and see a link to edit password" do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: '80111',
                            email_address: "George@example.com",
                            password: "superEasyPZ")
      new_password = 'iLikeTuring'
      visit "/login"

      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")

      visit '/profile'
      click_link("Edit Password")

      expect(current_path).to eq('/profile/password/edit')

      expect(page).to have_content('Update Password')
      fill_in 'Password', with: new_password
      fill_in 'Confirm Password', with: new_password
      click_button 'Update Password'

      expect(current_path).to eq('/profile')
      expect(page).to have_content('Password was successfully updated!')
    end

    it 'cannot use an email that is already in the database' do
      user_1 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: '80111',
                            email_address: "George@example.com",
                            password: "superEasyPZ")
      user_2 = User.create!(name: "Shaun",
                            street_address: "100 Elm St",
                            city: "Denver",
                            state: "CO",
                            zip: '80111',
                            email_address: "JackSkellinton@example.com",
                            password: "superEasyPZ")
      visit "/login"

      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")

      click_link "Edit Profile"
      fill_in("Email Address", with: "#{user_1.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      fill_in("Confirm Password", with: "#{user_2.password}")

      click_button('Submit Changes')

      expect(current_path).to eq('/profile/edit')
      expect(page).to have_content("Please select a unique email!")
    end

    it "has a link to the user's profile/orders page" do
      user_2 = User.create!(name: "George",
                            street_address: "123 lane",
                            city: "Denver",
                            state: "CO",
                            zip: 80111,
                            email_address: "George@example.com",
                            password: "superEasyPZ")
                            visit "/login"

      click_link "Log In"
      fill_in("Email Address", with: "#{user_2.email_address}")
      fill_in("Password", with: "#{user_2.password}")
      click_button("Submit")
      visit ("/profile")

      expect(page).to have_link("My Orders")
      click_link("My Orders")
      expect(current_path).to eq("/profile/orders")
    end
  end
end
