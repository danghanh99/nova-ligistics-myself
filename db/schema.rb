# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_26_084012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exports", force: :cascade do |t|
    t.integer "sell_price"
    t.integer "quantity"
    t.string "description"
    t.date "exported_date"
    t.bigint "user_id"
    t.bigint "import_id"
    t.bigint "inventory_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["import_id"], name: "index_exports_on_import_id"
    t.index ["inventory_id"], name: "index_exports_on_inventory_id"
    t.index ["user_id"], name: "index_exports_on_user_id"
  end

  create_table "imports", force: :cascade do |t|
    t.integer "retail_price"
    t.integer "quantity"
    t.string "description"
    t.date "imported_date"
    t.bigint "user_id"
    t.bigint "inventory_id"
    t.bigint "product_id"
    t.bigint "supplier_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_id"], name: "index_imports_on_inventory_id"
    t.index ["product_id"], name: "index_imports_on_product_id"
    t.index ["supplier_id"], name: "index_imports_on_supplier_id"
    t.index ["user_id"], name: "index_imports_on_user_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "description"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "email"
    t.string "encrypted_password"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "exports", "imports"
  add_foreign_key "imports", "inventories"
  add_foreign_key "imports", "products"
end
