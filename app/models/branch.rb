class Branch < ApplicationRecord
    has_many :schedules
    has_many :appointments
    
    validates_presence_of :name, message: 'El nombre no puede estar vacio' 
    validates_presence_of :address, message: 'La direccion no puede estar vacia' 
    validates_presence_of :phone_number, message: 'El telefono no puede estar vacio'
    validates_uniqueness_of :name, message: 'El nombre de la sucursal ya existe'

    def to_s
        name
    end
end
