class Appointment < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :branch
  belongs_to :employee, class_name: 'User'

  enum status: [:pending, :canceled, :attended]

  validates :date, presence: true
  validates :motive, presence: true
  validates :status, presence: true
  

  after_initialize :set_default_status, :if => :new_record?
  
  def set_default_status
    self.status ||= :pending
  end
end
