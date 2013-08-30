desc 'drop, create and rebuild development db'
task :rebuild_db => :environment do
  puts "drop the db"
  Rake::Task['db:drop'].execute
  puts "create the db"
  Rake::Task['db:create'].execute
  puts "run the migrations"
  Rake::Task['db:migrate'].execute
  puts "add seed data"
  Rake::Task['db:seed'].execute
  puts "add default users"
  Rake::Task['add_default_users'].execute
  # do other stuff...
end

desc 'Adding default Users'
task :add_default_users => :environment do
  g = Group.create(name: "Keshavnagar, Pune")
  u = User.new(first_name: "Kalpesh", last_name: "Fulpagare", email: "kalpesh.fulpagare@gmail.com", username: 'kalpesh', password: 'kalpesh123', password_confirmation:'kalpesh123')
  u.group_id = g.id
  u.save
  puts u.errors.any? ? u.errors.full_messages : "User => Kalpesh created successfully"
  u = User.new(first_name: "Yatin", last_name: "Rathod", email: "yatin.rathod5@gmail.com", username: 'yatin', password: 'yatin123', password_confirmation:'yatin123')
  u.group_id = g.id
  u.save
  puts u.errors.any? ? u.errors.full_messages : "User => Yatin created successfully"
end