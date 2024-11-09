class AddDefaultsToUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :failed_attempts, 0
    change_column_default :users, :locked_until, nil
    change_column_default :users, :otp_required_for_login, false
    change_column_default :users, :two_factor_enabled, false
  end
end
