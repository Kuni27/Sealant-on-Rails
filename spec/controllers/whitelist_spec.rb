# frozen_string_literal: true

# spec/controllers/whitelists_controller_spec.rb

require 'rails_helper'

RSpec.describe WhitelistsController, type: :controller do
  let(:admin_user) { User.create(email: 'admin@example.com') }
  let(:non_admin_user) { User.create(email: 'user@example.com') }
  let(:valid_attributes) { { email: 'test@example.com', role: 'admin' } }
  let(:invalid_attributes) { { email: '', role: 'user' } }

  before do
    # Mock the OmniAuth authentication process
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:provider] = :google_oauth2 # Replace with your actual OmniAuth provider

    # Manually set the current_user in the controller
    allow(controller).to receive(:authenticate_admin!)
    allow(controller).to receive(:current_user).and_return(admin_user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      whitelist = Whitelist.create!(valid_attributes)
      get :show, params: { id: whitelist.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      whitelist = Whitelist.create!(valid_attributes)
      get :edit, params: { id: whitelist.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Whitelist' do
        expect do
          post :create, params: { whitelist: valid_attributes }
        end.to change(Whitelist, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create, params: { whitelist: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { email: 'new_email@example.com' } }

      it 'updates the requested whitelist' do
        whitelist = Whitelist.create!(valid_attributes)
        put :update, params: { id: whitelist.to_param, whitelist: new_attributes }
        whitelist.reload
        expect(whitelist.email).to eq('new_email@example.com')
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        whitelist = Whitelist.create!(valid_attributes)
        put :update, params: { id: whitelist.to_param, whitelist: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested whitelist' do
      whitelist = Whitelist.create!(valid_attributes)
      expect do
        delete :destroy, params: { id: whitelist.to_param }
      end.to change(Whitelist, :count).by(-1)
    end
  end
end
