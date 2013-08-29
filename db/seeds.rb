
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
SystemSetting.create(name: "cache", value: {'category' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_'), 'group' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_'), 'user' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')})
g = Group.create(name: "Keshavnagar, Pune")
u = User.new(first_name: "Kalpesh", last_name: "Fulpagare", email: "kalpesh.fulpagare@gmail.com", username: 'kalpesh', password: 'sapna123', password_confirmation:'sapna123')
u.is_admin = true
u.group_id = g.id
u.save
puts u.errors.any? ? u.errors.full_messages : "Admin created successfully"
u = User.first
Category.create(name: "Food", user_id: u.id)
Category.create(name: "Petrol", user_id: u.id)
Category.create(name: "Recharge", user_id: u.id)
Category.create(name: "Ticket Fare", user_id: u.id)
Category.create(name: "Snacks", user_id: u.id)
Category.create(name: "Rent", user_id: u.id)
Category.create(name: "Servicing", user_id: u.id)
Category.create(name: "Accessories", user_id: u.id)
Category.create(name: "Kirana", user_id: u.id)
Category.create(name: "Movie", user_id: u.id)
u = User.new(first_name: "Yatin", last_name: "Rathod", email: "yatin.rathod5@gmail.com", username: 'yatin', password: 'yatin123', password_confirmation:'yatin123')
u.group_id = g.id
u.save
puts u.errors.any? ? u.errors.full_messages : "Yatin created successfully"