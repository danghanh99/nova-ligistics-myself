class AddOnDeleteCascadeForImportExport < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :exports, :customers
    add_foreign_key :exports, :customers, on_delete: :cascade

    remove_foreign_key :exports, :imports
    add_foreign_key :exports, :imports, on_delete: :cascade

    remove_foreign_key :imports, :inventories
    add_foreign_key :imports, :inventories, on_delete: :cascade

    remove_foreign_key :imports, :products
    add_foreign_key :imports, :products, on_delete: :cascade
  end
end
