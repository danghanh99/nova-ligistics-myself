class AddCustomerToExports < ActiveRecord::Migration[6.1]
  def change
    add_reference :exports, :customer, null: false, foreign_key: true
  end
end
