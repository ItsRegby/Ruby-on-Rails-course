class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  LOCKOUT_PERIOD = 10.minutes
  MAX_FAILED_ATTEMPTS = 3

  def increment_failed_attempts!
    if failed_attempts < MAX_FAILED_ATTEMPTS - 1
      update(failed_attempts: failed_attempts + 1)
    else
      lock_account!
    end
  end

  has_one_attached :avatar
  validates :first_name, presence: true
  validates :phone_number, presence: true
  validates :date_of_birth, presence: true


  def generate_otp_secret!
    self.otp_secret = ROTP::Base32.random_base32
    save!
  end

  def verify_otp(code)
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(code, drift: 60)
  end

  def two_factor_enabled?
    otp_required_for_login && otp_secret.present?
  end

  def lock_account!
    update(failed_attempts: 0, locked_until: Time.current + LOCKOUT_PERIOD)
  end

  def unlock_account!
    update(locked_until: nil, failed_attempts: 0)
  end

  def locked?
    locked_until.present? && Time.current + LOCKOUT_PERIOD > Time.current
  end
end
