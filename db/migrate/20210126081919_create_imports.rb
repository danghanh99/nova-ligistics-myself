class CreateImports < ActiveRecord::Migration[6.1]
  def change
    create_table :imports do |t|
      t.integer :retail_price
      t.integer :quantity
      t.string :notes
      t.date :date_input
      t.references :user, index: true, foreign_key: true
      t.references :inventory, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.references :suplier, index: true, foreign_key: true

      t.timestamps
    end
  end
end
