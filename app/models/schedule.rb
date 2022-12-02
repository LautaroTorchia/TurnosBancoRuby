class Schedule < ApplicationRecord
  belongs_to :branch
  
  validates :open_at, :presence => true
  validates :close_at, :presence => true
  validates :day, :presence => true
  validates :day, inclusion: { in: ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"],
    message: "%{value} no es un dia valido" }
  
  validates :day, uniqueness: { scope: :branch_id,
    message: "ya existe un horario para este dia" }
  
  #validate that open hour is before close hour
  validate :open_before_close

  def open_before_close
    if open_at >= close_at
      errors.add(:open_at, "La hora de apertura debe ser antes de la hora de cierre")
    end
  end

end
