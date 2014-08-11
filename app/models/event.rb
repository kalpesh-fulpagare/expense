class Event < ActiveRecord::Base
  attr_accessible :name, :description, :date, :total_cost, :participant_ids, :status

  # Validations
  validates :name, :user_id, :date, :total_cost, presence: true
  validates :total_cost, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1 Rs" }, allow_blank: true

  # Associations
  belongs_to :user
  belongs_to :group

  STATUS = {0 => "Incomplete", 1 => "Complete"}

  after_save :updated_list

  # Delegates
  delegate :display_name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :group, prefix: true, allow_nil: true

  serialize :participant_ids, Array

  def updated_list
    puts "\n\n\n\n\n\n", self.previous_changes, "\n\n\n\n\n\n"
  end

  def participant_ids=(value)
    value.reject!(&:blank?)
    write_attribute(:participant_ids, value)
  end

  def participant_names
    User.select("first_name, last_name, id").where(id: participant_ids).map(&:display_name)
  end
end
