class Appointment < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :branch, optional: false
  belongs_to :employee, class_name: 'User', optional: true

  enum status: [:pending, :canceled, :attended]

  validates :date, presence: true
  validates :motive, presence: true
  validates :status, presence: true

  #validate that the date is between branch schedule hours
  validate :date_is_between_branch_schedule_hours

  #validate that the date is not in the past
  validate :date_is_not_in_the_past
  
  def date_is_not_in_the_past
    if date < Date.today
      errors.add(:date, "La fecha no puede ser en el pasado")
    end
  end
  
  def date_is_between_branch_schedule_hours
    
    days=["Domingo","Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"]
    if ! branch.schedules.find_by(day: days[date.wday]).nil?
      my_day_open_at=  branch.schedules.find_by(day: days[date.wday]).open_at
      my_day_close_at= branch.schedules.find_by(day: days[date.wday]).close_at
      if date.present? && branch.present?
        if date.hour < my_day_open_at.hour || date.hour > my_day_close_at.hour
          errors.add(:date, "La fecha debe estar dentro del horario de la sucursal, 
            el cual es de #{my_day_open_at.strftime("%H:%M")} a #{my_day_close_at.strftime("%H:%M")}")
        end
      end
    else
      errors.add(:date, "La sucursal no abre ese dia")
    end
  end


  

  after_initialize :set_default_status, :if => :new_record?
  
  def set_default_status
    self.status ||= :pending
  end
end
