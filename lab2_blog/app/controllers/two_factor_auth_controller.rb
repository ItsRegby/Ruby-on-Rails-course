# app/controllers/two_factor_auth_controller.rb
class TwoFactorAuthController < ApplicationController
  before_action :authenticate_user!, only: [:show, :verify]

  def show
    @user = User.find(session[:otp_user_id])
  end

  def verify
    @user = User.find(session[:otp_user_id])

    if @user.verify_otp(params[:otp_code])
      session[:otp_user_id] = nil
      sign_in(@user)
      redirect_to root_path, notice: 'Двофакторна аутентифікація успішна!'
    else
      flash[:alert] = 'Неправильний код OTP, спробуйте ще раз.'
      render :show
    end
  end
end
