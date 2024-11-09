class SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])

    if user&.locked?
      redirect_to '/users/sign_in', alert: "Your account has been locked for 10 minutes due to multiple failed login attempts." and return
    end

    if user && !user.valid_password?(params[:user][:password])
      user.increment_failed_attempts!
      redirect_to '/users/sign_in', alert: "Invalid password. Your account will be blocked after 3 unsuccessful attempts." and return
    end

    if user && user.two_factor_enabled?
      session[:otp_user_id] = user.id
      redirect_to two_factor_auth_path and return
    end

    super do |authenticated_user|
      if authenticated_user
        authenticated_user.unlock_account!
      end
    end
  end
end