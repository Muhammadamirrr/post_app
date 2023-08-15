require 'rails_helper'

RSpec.feature 'User Sign Up', type: :feature do
  scenario 'with valid email and password' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'with invalid email' do
    visit new_user_registration_path

    fill_in 'Email', with: 'invalid-email'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Sign up')
  end

  scenario 'with passwords that do not match' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'mismatched-password'

    click_button 'Sign up'

    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end

  scenario 'with too short password' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'short'

    click_button 'Sign up'

    expect(page).to have_content('Password is too short')
  end

  scenario 'with blank fields' do
    visit new_user_registration_path

    click_button 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end
