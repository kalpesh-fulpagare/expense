class SystemSetting < ActiveRecord::Base
  attr_accessible :name, :value

  serialize :value, Hash

  class << self
    def find_settlement year
      year = Time.now.year if year.blank?
      ss = find_by_name("#{year}_settlement")
      ss = create(name: "#{year}_settlement", value: {}) unless ss
      ss
    end

    def calculate_last_settlement user
      if user.group_id
        user_ids = User.where(:group_id => user.group_id).pluck(:id)
        date = Date.today - 30.days
        expenses = Expense.where(user_id: user_ids).select("user_id, SUM(cost) AS cost")
        expenses = expenses.where("MONTH(date) = ? AND YEAR(date) = ?", date.month, date.year).group("user_id")
        record = expenses.inject({}) do |record, e|
          record[e.user_id] = e.cost
          record
        end
        ss = find_settlement date.year
        ss.value[date.strftime("%B")] = record
        ss.update_attribute(:value, ss.value)
      end
    end
  end
end
