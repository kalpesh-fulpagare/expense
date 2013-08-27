
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.last.blank?
  u = User.new(first_name: "Kalpesh", last_name: "Fulpagare", email: "kalpesh.fulpagare@gmail.com", username: 'kalpesh', password: 'sapna123',password_confirmation:'sapna123')
  u.is_admin = true
  u.save
  puts u.errors.any? ? u.errors.full_messages : "Admin created successfully"
end
