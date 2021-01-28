class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone_number
      t.string :address, null: true

      t.timestamps
    end
  end
end
