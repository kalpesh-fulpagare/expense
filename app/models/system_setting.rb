class SystemSetting < ActiveRecord::Base
  attr_accessible :name, :value

  serialize :value, Hash
end
