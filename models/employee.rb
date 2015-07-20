class Employee < ActiveRecord::Base
  belongs_to :store

  validates :first_name, presence: true
  validates :last_name, presence: true
  after_save :employee_increase, on: :create
  after_update :update_employees
  after_destroy :employee_decrease
  after_save :annual_salary
  #after_save :average_hourly_rate_for


  @increment = true

  def self.average_hourly_rate_for(gender)

    if gender == nil
      Employee.all.average(:hourly_rate).round(2)
    else

    Employee.where(:gender => gender).all.average(:hourly_rate).round(2)
  end


        #self.average(:hourly_rate)

  end

  def employee_increase
   # if @increment == true
    if self.gender == "F"
       self.store.female_employees += 1
     elsif self.gender == "M"
       self.store.male_employees += 1
     end

  end

  def update_employees
    if self.gender == "F"
      self.store.female_employees -= 1
     elsif self.gender == "M"
       self.store.male_employees -= 1
     end

   end

  def employee_decrease
   # if @increment == true
    if self.gender == "F"
       self.store.female_employees -= 1
     elsif self.gender == "M"
       self.store.male_employees -= 1
     end

  end

  def annual_salary
   salary =  self.hourly_rate * 1950

  end


  
end


