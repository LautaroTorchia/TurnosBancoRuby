class Branch < ApplicationRecord
    has_many :schedules

    def to_s
        name
    end
end
