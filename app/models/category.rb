class Category < ActiveRecord::Base

  attr_accessible :name, :user_id, :category_type

  # Validations
  validates :name, presence: true, uniqueness: true

  # Associations
  has_many :expenses
  has_many :users

  # Constants
  TYPES = {"exp" => "Expense", "personal_exp" => "Personal Expense"}

  # Callbacks
  after_save :update_cache_time
  after_destroy :update_cache_time

  def update_cache_time
    ss = SystemSetting.find_by_name("cache")
    ss.value['category'] = Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')
    ss.update_attribute(:value, ss.value)
  end
end
