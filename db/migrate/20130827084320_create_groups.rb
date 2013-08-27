class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :user_ids
      t.integer :owner_id

      t.timestamps
    end
    u = User.new(first_name: "Kalpesh", last_name: "Fulpagare", email: "kalpesh.fulpagare@gmail.com", username: 'kalpesh', password: 'sapna123',password_confirmation:'sapna123')
    u.is_admin = true
    u.save
  end
end
