require 'rails_helper'

RSpec.feature 'Edit Post', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit edit_post_path(1)
  end

  scenario 'with valid changes' do
    fill_in 'title', with: 'Updated Title'
    fill_in 'body', with: 'Updated Content'

    click_button 'Update Post'

    expect(page).to have_content('Post updated successfully')
  end
end
