class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login, :current_password
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :username, :login, :current_password

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :first_name, :first_name, presence: true

  # Associations
  has_many :expenses
  belongs_to :group

  # Callbacks
  after_save :update_cache_time

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end

  def update_cache_time
    ss = SystemSetting.find_by_name("cache")
    ss.value['user'] = Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')
    ss.update_attribute(:value, ss.value)
  end
end
