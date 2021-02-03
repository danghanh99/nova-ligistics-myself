# Default User
admin = User.create_with(
  email: "admin@novahub.vn",
  password: "Nova@123",
  name: "admin",
  phone: "0905010203",
  address: '10B Nguyen Chi Thanh'
).find_or_create_by(email: 'admin@novahub.vn')

# Default Inventory

nova_inventory = Inventory.create_with(
  name: "Novahub 2021",
  address: '10B Nguyen Chi Thanh',
  description: 'This is branch 1'
).find_or_create_by(name: 'Novahub 2021')

cty_xnk_an_giang = Supplier.create_with(
  name: "Công ty CP Xuất Nhập Khẩu An Giang - Angimex",
  phone: '02963841548',
  address: '01, Ngô Gia Tự, TP. Long Xuyên, An Giang',
  description: ''
).find_or_create_by(name: 'Công ty CP Xuất Nhập Khẩu An Giang - Angimex')

rice = Product.find_or_create_by name: 'viet nam rice', description: 'One of the best rice', sku: 'kg'

import_rice = Import.create_with(
  retail_price: 20_000_000,
  quantity: 100,
  description: '',
  imported_date: '28-01-2021',
  user_id: admin.id,
  inventory_id: nova_inventory.id,
  supplier_id: cty_xnk_an_giang.id,
  product_id: rice.id
).find_or_create_by(imported_date: '28-01-2021', supplier_id: cty_xnk_an_giang.id, retail_price: 20_000_000)
