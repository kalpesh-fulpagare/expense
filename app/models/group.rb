class Group < ActiveRecord::Base
  attr_accessible :name, :owner_id, :user_ids
end
