require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  let(:user) { create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'redirects to posts_dashboard_index_path' do
        post :create, params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'remains on the new login page' do
        post :create, params: { user: { email: user.email, password: 'wrong_password' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in(user) }

    it 'signs out the user' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
