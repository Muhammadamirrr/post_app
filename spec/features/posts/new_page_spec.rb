require 'rails_helper'

RSpec.feature 'New Post Page', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit edit_post_path(1)
  end

  scenario 'creates a new post with valid data' do
    visit new_post_path

    fill_in 'Title', with: 'New Post Title'
    click_button 'Create Post'

    expect(page).to have_content('Post created successfully')
  end

  scenario 'redirects back to posts index page' do
    visit new_post_path

    click_link 'Back to Posts'

    expect(page).to have_current_path(posts_path)
  end
end
