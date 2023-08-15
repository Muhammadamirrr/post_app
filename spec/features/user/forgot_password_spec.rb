require 'rails_helper'

RSpec.feature 'Forgot Password', type: :feature do
  scenario 'with valid email' do
    create(:user, email: 'test@example.com')

    visit new_user_password_path

    fill_in 'Email', with: 'test@example.com'
    click_button 'Send me reset password instructions'

    expect(page).to have_text('Log in')
  end

  scenario 'with invalid email' do
    visit new_user_password_path

    fill_in 'Email', with: 'invalid@example.com'
    click_button 'Send me reset password instructions'

    expect(page).to have_text('Email not found')
  end
end
