class Event < ActiveRecord::Base
  attr_accessible :name, :description, :date, :total_cost, :participant_ids

  # Validations
  validates :name, :user_id, :date, :total_cost, presence: true
  validates :total_cost, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1 Rs" }, allow_blank: true

  # Associations
  belongs_to :user
  belongs_to :group

  STATUS = {0 => "Incomplete", 1 => "Complete"}

  serialize :participant_ids, Array

  def participant_names
    User.select("first_name, last_name, id").where(id: participant_ids).map(&:display_name)
  end
end
