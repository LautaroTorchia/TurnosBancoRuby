class Schedule < ApplicationRecord
  belongs_to :branch
  
  validates :open_at, :presence => true
  validates :close_at, :presence => true
  validates :day, :presence => true
  validates :day, inclusion: { in: ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"],
    message: "%{value} no es un dia valido" }
  
  validates :day, uniqueness: { scope: :branch_id,
    message: "ya existe un horario para este dia" }
end
