class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show; end

  def edit; end

  def update
    if params[:user][:two_factor_enabled] == "true"
      enable_2fa
    elsif params[:user][:two_factor_enabled] == "false"
      disable_2fa
    end

    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_profile_path, alert: 'Could not update profile.'
    end
  end

  private

  def enable_2fa
    @user.generate_otp_secret!
    @user.update(otp_required_for_login: true)
    flash[:notice] = "Two-factor authentication enabled."
  end

  def disable_2fa
    @user.update(otp_required_for_login: false, otp_secret: nil)
    flash[:notice] = "Two-factor authentication disabled."
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :date_of_birth, :avatar, :two_factor_enabled)
  end
end
