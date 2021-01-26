class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :email
      t.string :encrypted_password
    end
    add_index :users, :email, unique: true
  end
end
