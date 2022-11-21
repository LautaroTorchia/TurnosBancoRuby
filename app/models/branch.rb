class Branch < ApplicationRecord
    has_many :schedules
    
    validates :name, :presence => true
    validates :address, :presence => true
    validates :phone_number, :presence => true

    def to_s
        name
    end
end
