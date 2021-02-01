class AddSqlUniqueConstraintPhoneNumber < ActiveRecord::Migration[6.1]
  def change
    add_index :customers, :phone_number, unique: true
  end
end
