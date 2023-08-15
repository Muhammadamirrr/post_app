require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: 'Test Post', body: 'This is a test post.' } }

  before { sign_in(user) }

  shared_examples 'a successful action' do |flash_key|
    it 'redirects to posts_path' do
      subject
      expect(response).to redirect_to(posts_path)
      expect(flash[flash_key]).to be_present
    end
  end

  describe 'GET #index' do
    before { get :index }

    it 'renders the posts page' do
      expect(response).to render_template(:index)
    end

    it 'assigns @posts' do
      expect(assigns(:posts)).to be_present
    end
  end

  describe 'POST #create' do
    let(:subject) { post :create, params: { post: valid_attributes } }

    context 'with valid attributes' do
      it_behaves_like 'a successful action', 'alert alert-success'
    end
  end

  describe 'GET #edit' do
    let(:post_data) { { 'body' => 'Content', 'id' => 1, 'title' => 'New Post1', 'userId' => 1 } }
    before do
      allow(controller).to receive(:fetch_data).and_return(post_data)
      get :edit, params: { id: 1 }
    end

    it 'renders the edit post page' do
      expect(response).to render_template(:edit)
    end

    it 'assigns @post' do
      expect(assigns(:post)).to eq(post_data)
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { title: 'Updated Title' } }
    let(:subject) { put :update, params: { id: 1, post: new_attributes } }

    context 'with valid attributes' do
      it_behaves_like 'a successful action', 'alert alert-info'
    end
  end

  describe 'DELETE #destroy' do
    let(:subject) { delete :destroy, params: { id: 1 } }

    it_behaves_like 'a successful action', 'alert alert-info'
  end
end
