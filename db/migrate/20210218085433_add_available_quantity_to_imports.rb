class AddAvailableQuantityToImports < ActiveRecord::Migration[6.1]
  def change
    add_column :imports, :available_quantity, :integer
  end
end
