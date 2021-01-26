class CreateSupliers < ActiveRecord::Migration[6.1]
  def change
    create_table :supliers do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :notes

      t.timestamps
    end
  end
end
