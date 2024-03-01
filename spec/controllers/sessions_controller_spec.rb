# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create(username: 'test_user', email: 'test@example.com') }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '123456',
                                                                         info: {
                                                                           name: 'John Doe',
                                                                           email: 'john@gmail.com'
                                                                         }
                                                                       })
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    context 'when logged in' do
      before { allow(controller).to receive(:logged_in?).and_return(true) }

      it 'redirects to root_path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { session: { username: user.username, password: 'password' } } }
    let(:invalid_params) { { session: { username: 'nonexistent_user', password: 'wrong_password' } } }

    it 'creates a session for a whitelisted user' do
      Whitelist.create(email: user.email)
      post :create, params: valid_params
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(login_path)
    end

    it 'redirects to login_path for non-whitelisted user' do
      post :create, params: invalid_params
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
      expect(flash[:error]).to include('You are not whitelisted.Contact your administrator.')
    end

    context 'with non-whitelisted user' do
      it 'redirects to login_path' do
        post :create, params: { session: { username: 'nonexistent_user', password: 'password' } }
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:error]).to include('You are not whitelisted.Contact your administrator.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the user session' do
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #omniauth' do
    let(:omniauth_auth) { OmniAuth.config.mock_auth[:google_oauth2] }

    before do
      request.env['omniauth.auth'] = omniauth_auth
      Whitelist.create(email: omniauth_auth.info.email)
    end

    it 'creates or finds a user through omniauth' do
      expect do
        get :omniauth, params: { provider: omniauth_auth.provider, uid: omniauth_auth.uid }
      end.to change(User, :count).by(1)

      expect(session[:user_id]).to eq(User.last.id)
      expect(response).to redirect_to(root_path)

      # Reset the session
      session[:user_id] = nil
    end

    # it 'handles authentication failure' do
    #   OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials # Mock an authentication failure
    #
    #   get :omniauth, params: { provider: 'google_oauth2' }
    #
    #   expect(session[:user_id]).to be_nil
    #   expect(response).to redirect_to(login_path)
    #   expect(flash[:error]).to include('Failed to create or authenticate user.')
    # end

    context 'with non-whitelisted user' do
      it 'redirects to login_path' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
        # Ensure the user is not on the whitelist
        Whitelist.where(email: omniauth_auth.info.email).destroy_all

        get :omniauth, params: { provider: 'google_oauth2', uid: '123456' }

        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:error]).to include('You are not whitelisted.Contact your administrator.')
      end
    end
  end

  # describe '#check_whitelist' do
  #   it 'redirects to login_path for non-whitelisted user' do
  #     allow(controller).to receive(:params).and_return(session: { username: 'nonexistent_user' })
  #     get :check_whitelist
  #     expect(response).to redirect_to(login_path)
  #     expect(flash[:error]).to include('You are not whitelisted.Contact your administrator.')
  #   end
  #
  #   it 'does not redirect for whitelisted user' do
  #     Whitelist.create(email: user.email)
  #     allow(controller).to receive(:params).and_return(session: { username: user.username })
  #     get :check_whitelist
  #     expect(response).not_to redirect_to(login_path)
  #     expect(flash[:error]).to be_nil
  #   end
  # end
end
