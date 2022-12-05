class BranchesController < ApplicationController
  before_action :set_branch, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /branches or /branches.json
  def index
    @branches = Branch.all
  end

  # GET /branches/1 or /branches/1.json
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches or /branches.json
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to branch_url(@branch), notice: "Branch was successfully created." }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1 or /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to branch_url(@branch), notice: "La sucursal fue correctamente actualizada." }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1 or /branches/1.json
  def destroy
    #Add logic to not allow deletion if there are pending apointments in the branch copilot
    branch_appointments=@branch.appointments.filter { |appointment| appointment.pending? } 
    branch_employees= User.where(branch_id: @branch.id)
    if branch_appointments.any? || branch_employees.any?
      redirect_to branch_url(@branch), notice: "No se puede borrar la sucursal porque tiene citas pendientes o empleados asignados"
    else 
      @branch.appointments.each do |appointment|
        appointment.destroy
      end
      @branch.schedules.each do |schedule|
        schedule.destroy
      end

      @branch.destroy

      respond_to do |format|
        format.html { redirect_to branches_url, notice: "La sucursal fue correctamente borrada." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_params
      params.require(:branch).permit(:name, :address, :phone_number)
    end
end
