class Group < ActiveRecord::Base
  attr_accessible :name, :owner_id, :user_ids

  # Validations
  validates :name, presence: true, uniqueness: true

  has_many :users, select: "id, first_name, last_name, username, group_id"

  after_save :update_cache_time

  def update_cache_time
    ss = SystemSetting.find_by_name("cache")
    ss.value['group'] = Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')
    ss.update_attribute(:value, ss.value)
  end
end
