class Event < ActiveRecord::Base
  attr_accessible :name, :description, :date

  # Validations
  validates :name, :user_id, :date, presence: true #:participant_ids,

  # Associations
  belongs_to :user
  belongs_to :group

  STATUS = {0 => "Incomplete", 1 => "Complete"}

  serialize :participant_ids, Array
end
