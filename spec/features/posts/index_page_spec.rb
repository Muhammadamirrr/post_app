require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit posts_path
  end

  scenario 'displays list of posts' do
    expect(page).to have_content('New Post1')
    expect(page).to have_content('New Post2')
    expect(page).to have_content('Content')
  end

  scenario 'links to new post page' do
    click_link 'New Post'
    expect(page).to have_current_path(new_post_path)
  end

  scenario 'links to edit post page' do
    within('#post_1') do
      click_link 'Edit'
    end
    expect(page).to have_current_path(edit_post_path(1))
  end

  scenario 'deletes a post' do
    within('#post_2') do
      click_button 'Delete Post'
    end
    expect(page).to have_content('Delete successful')
  end
end
