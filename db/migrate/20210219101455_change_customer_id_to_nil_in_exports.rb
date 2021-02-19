class ChangeCustomerIdToNilInExports < ActiveRecord::Migration[6.1]
  def change
    change_column :exports, :customer_id, :bigint, :null => true
  end
end
