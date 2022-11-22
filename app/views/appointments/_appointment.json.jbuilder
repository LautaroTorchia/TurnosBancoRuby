json.extract! appointment, :id, :client_id, :branch_id, :date, :motive, :status, :employee_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
