# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end

    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid user parameters' do
      let(:valid_user_params) do
        {
          user: {
            username: 'testuser',
            email: 'testuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post :create, params: valid_user_params
        end.to change(User, :count).by(1)
      end

      it 'logs in the new user and redirects to root path' do
        post :create, params: valid_user_params
        expect(session[:user_id]).to eq(User.last.id)
        expect(response).to redirect_to(root_path)
      end

      #   it 'renders the new template with invalid user parameters' do
      #     post :create, params: invalid_user_params
      #     expect(response).to render_template('new')
      #   end
    end

    context 'with invalid user parameters' do
      let(:invalid_user_params) do
        {
          user: {
            username: 'udbfbdf',  # Invalid username
            email: 'testuser@example.com',
            password: '',
            password_confirmation: ''
          }
        }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_user_params
        end.not_to change(User, :count)
      end

      it 're-renders the new template' do
        post :create, params: invalid_user_params
        expect(response).to render_template('new')
      end
    end
  end
end
