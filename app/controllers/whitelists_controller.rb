# frozen_string_literal: true

class WhitelistsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_whitelist, only: %i[show edit update destroy]

  # GET /whitelists or /whitelists.json
  def index
    @whitelists = Whitelist.all
  end

  # GET /whitelists/1 or /whitelists/1.json
  def show; end

  # GET /whitelists/new
  def new
    @whitelist = Whitelist.new
  end

  # GET /whitelists/1/edit
  def edit; end

  # POST /whitelists or /whitelists.json
  def create
    @whitelist = Whitelist.new(whitelist_params)

    respond_to do |format|
      if @whitelist.save
        format.html { redirect_to whitelist_url(@whitelist), notice: 'Whitelist was successfully created.' }
        format.json { render :show, status: :created, location: @whitelist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /whitelists/1 or /whitelists/1.json
  def update
    respond_to do |format|
      if @whitelist.update(whitelist_params)
        format.html { redirect_to whitelist_url(@whitelist), notice: 'Whitelist was successfully updated.' }
        format.json { render :show, status: :ok, location: @whitelist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /whitelists/1 or /whitelists/1.json
  def destroy
    @whitelist.destroy!

    respond_to do |format|
      format.html { redirect_to whitelists_url, notice: 'Whitelist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_whitelist
    @whitelist = Whitelist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def whitelist_params
    params.require(:whitelist).permit(:email, :role)
  end

  def authenticate_admin!
    whitelist_email = current_user&.email
    whitelist = Whitelist.find_by(email: whitelist_email)

    return if whitelist&.admin?

    flash[:error] = 'You do not have permission to access this page.'
    redirect_to root_path
  end
end
