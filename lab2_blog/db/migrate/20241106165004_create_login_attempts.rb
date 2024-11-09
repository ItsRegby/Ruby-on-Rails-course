class CreateLoginAttempts < ActiveRecord::Migration[7.2]
  def change
    create_table :login_attempts do |t|
      t.references :user, foreign_key: true
      t.string :ip_address, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
