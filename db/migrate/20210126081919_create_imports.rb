class CreateImports < ActiveRecord::Migration[6.1]
  def change
    create_table :imports do |t|
      t.integer :retail_price
      t.integer :quantity
      t.string :notes
      t.date :date_import
      t.references :user, index: true, foreign_key: false
      t.references :inventory, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.references :suplier, index: true, foreign_key: false

      t.timestamps
    end
  end
end
