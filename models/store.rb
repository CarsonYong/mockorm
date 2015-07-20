class Store < ActiveRecord::Base
  has_many :employees

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :annual_revenue, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, length: {minimum: 0}
  validates :male_employees, numericality: {greater_than_or_equal_to: 0 }
  validates :female_employees, numericality: {greater_than_or_equal_to: 0 }
  after_save :annual_expense
  after_save :annual_profit


def annual_expense
 sum =  Employee.sum(:hourly_rate) * 1950
end

def annual_profit
  sum = self.annual_revenue - self.annual_expense
end

end
