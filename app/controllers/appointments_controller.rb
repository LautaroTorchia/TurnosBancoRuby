class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /appointments or /appointments.json
  def index
    if current_user.admin?
      @actual_appointments= Appointment.all.order(date: :asc)
    elsif current_user.staff?
      puts DateTime.now 
      #appointments of today and only today
      @actual_appointments= Appointment.where("date >= ? AND date <= ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      .where(status: :pending ,branch_id: current_user.branch.id)

      #appointments of today and only today
      @ended_appointments= Appointment.where("date >= ? AND date <= ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      .where(status: [:attended,:canceled]).where(branch_id: current_user.branch.id)
      @date = Date.today
    else
      @ended_appointments= Appointment.where(status: [:attended,:canceled])
      @actual_appointments = Appointment.where(status: :pending)
    end
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    puts "llegue aca reputo"
    appointment_data= appointment_params
    appointment_data[:client_id] = current_user.id
    appointment_data[:status] = :pending
    puts appointment_data
    @appointment = Appointment.new(appointment_data)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointment_url(@appointment), notice: "Se registro el turno satisfactoriamente" }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      @appointment.status = :attended
      @appointment.employee_id = current_user.id
    
      if @appointment.save
        format.html { redirect_to appointments_path, notice: "Se registro la visita al turno Satisfactoriamente" }
        format.json { render :show, status: :ok, location: @appointment }
      else  
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.status = :canceled
    @appointment.save

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Se cancelo el turno satisfactoriamente" }
      format.json { head :no_content }
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through. allow branch name as a parameter
    def appointment_params
      params.require(:appointment).permit(:branch_id, :date, :motive, :status, :employee_id, :observations)
    end
end
