class SchedulesController < ApplicationController
  before_action :set_branch 
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /schedules or /schedules.json
  def index
    @schedules = Schedule.where(branch_id: @branch.id)
  end

  # GET /schedules/1 or /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        @branch.schedules << @schedule
        @branch.save
        format.html { redirect_to branch_schedule_url(@branch,@schedule), notice: "El horario fue correctamente creado." }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to branch_schedule_url(@branch,@schedule), notice: "El horario fue correctamente actualizado." }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to branch_schedules_path, notice: "El horario fue correctamente borrado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:branch_id])
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:open_at, :close_at, :day, :branch_id)
    end
end
