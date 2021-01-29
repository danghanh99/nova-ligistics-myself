# Default User
User.create_with(
  email: "admin@novahub.vn",
  password: "123456",
  name: "admin",
  phone: "0905010203",
  address: '10B Nguyen Chi Thanh'
).find_or_create_by(email: 'admin@novahub.vn')

# Default Inventory
Inventory.create_with(
  name: "Novahub 2021",
  address: '10B Nguyen Chi Thanh',
  description: 'This is branch 1'
).find_or_create_by(name: 'Novahub 2021')