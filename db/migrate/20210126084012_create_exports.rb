class CreateExports < ActiveRecord::Migration[6.1]
  def change
    create_table :exports do |t|
      t.integer :sell_price
      t.integer :quantity
      t.string :description
      t.date :exported_date
      t.references :user, index: true, foreign_key: false
      t.references :import, index: true, foreign_key: true
      t.references :inventory, index: true, foreign_key: false

      t.timestamps
    end
  end
end
