class AddFailedAttemptsAndLockedUntilToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :failed_attempts, :integer
    add_column :users, :locked_until, :datetime
  end
end
