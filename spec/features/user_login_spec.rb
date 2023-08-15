require 'rails_helper'

RSpec.feature 'User Login', type: :feature do
  scenario 'with valid credentials' do
    create(:user, email: 'test@example.com', password: 'password')

    visit new_user_session_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'with invalid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'invalidpassword'
    click_button 'Log in'

    expect(page).to have_text('Log in')
  end

  scenario 'with remember me option' do
    create(:user, email: 'test@example.com', password: 'password')

    visit new_user_session_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    check 'Remember me'
    click_button 'Log in'

    expect(page).to have_text('Signed in successfully.')
  end
end
