
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Group.destroy_all
Category.destroy_all
SystemSetting.destroy_all
SystemSetting.create(name: "cache", value: {'category' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_'), 'group' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_'), 'user' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')})
SystemSetting.create(name: "RoomRent", value: {'Unit' => '8', 'Rent' => '6100'})
puts "Admin account creation ============>"
puts "Enter password for admin account:"
password = STDIN.gets.chomp
u = Admin.new(first_name: "Expense", last_name: "Admin", email: "admin@expense.com", username: 'admin', password: password)
u.is_admin = true
u.save
puts u.errors.any? ? u.errors.full_messages : "Admin created successfully!\nLogin Credentials: admin/#{password}"

# Category.create(name: "Food", user_id: u.id, category_type: "exp")
# Category.create(name: "Accessories", user_id: u.id, category_type: "exp")
# Category.create(name: "Movie", user_id: u.id, category_type: "exp")
# Category.create(name: "Snacks", user_id: u.id, category_type: "exp")
# Category.create(name: "Kirana", user_id: u.id, category_type: "exp")
# Category.create(name: "Rent", user_id: u.id, category_type: "exp")
# Category.create(name: "Vegetables", user_id: u.id, category_type: "exp")
# Category.create(name: "Chapati", user_id: u.id, category_type: "exp")

# Category.create(name: "Food", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Accessories", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Movie", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Snacks", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Kirana", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Petrol", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Recharge", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Ticket Fare", user_id: u.id, category_type: "personal_exp")
# Category.create(name: "Servicing", user_id: u.id, category_type: "personal_exp")