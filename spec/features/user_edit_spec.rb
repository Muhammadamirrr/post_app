require 'rails_helper'

RSpec.feature 'Edit Profile', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)

    visit edit_user_registration_path
  end

  def update_profile(email:, password:, password_confirmation:, current_password:)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
    fill_in 'Current password', with: current_password
    click_button 'Update'
  end

  scenario 'with valid changes' do
    update_profile(
      email: 'new_email@example.com',
      password: 'new_password',
      password_confirmation: 'new_password',
      current_password: user.password
    )

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'with invalid changes' do
    update_profile(
      email: 'new_email@example.com',
      password: 'new_password',
      password_confirmation: 'new_password',
      current_password: ''
    )

    expect(page).to have_content('prohibited this user from being saved')
    expect(page).to have_content("Current password can't be blank")
  end

  scenario 'cancel account deletion' do
    click_button 'Cancel my account'

    expect(page).to have_content('You need to sign in or sign up before continuing')
  end
end
