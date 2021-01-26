class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
