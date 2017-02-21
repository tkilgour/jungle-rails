require 'rails_helper'

RSpec.feature "Visitor enters their login info and sees they are logged in", type: :feature, js: true do
  # SETUP
  before :each do
    User.create!(
      first_name: 'Desmond',
      last_name: 'Derango',
      email: 'dd@rango.com',
      password: 'helloworld',
      password_confirmation: 'helloworld'
    )
  end

  scenario 'They enter their login info, press \'Submit\', and see they are logged in' do
    visit login_path
    fill_in 'email', with: 'dd@rango.com'
    fill_in 'password', with: 'helloworld'
    save_screenshot 'user-login.png'

    click_on 'Submit'
    within('.navbar') { expect(page).to have_content('Desmond') }
    save_screenshot 'user-login2.png'
  end
end
