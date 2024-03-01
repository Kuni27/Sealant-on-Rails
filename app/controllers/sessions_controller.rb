# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :check_whitelist, only: %i[create omniauth]

  def new
    return unless logged_in?

    redirect_to root_path
  end

  def create
    @user = User.find_by(username: params[:session][:username])

    if @user&.authenticate(params[:session][:password]) && Whitelist.exists?(email: @user.email)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = 'Invalid username, password, or you are not whitelisted.'
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  def omniauth
    @user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'],
                                   provider: request.env['omniauth.auth']['provider']) do |u|
      u.username = request.env['omniauth.auth']['info']['name']
      u.email = request.env['omniauth.auth']['info']['email']
      u.password = SecureRandom.hex(10)
    end

    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = 'Failed to create or authenticate user.'
      redirect_to login_path
    end
  end

  def check_whitelist
    email = params.dig(:session, :username) || request.env['omniauth.auth']['info']['email']
    return if Whitelist.exists?(email:)

    flash[:error] = 'You are not whitelisted.Contact your administrator.'
    redirect_to login_path
  end
end
