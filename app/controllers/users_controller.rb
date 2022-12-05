class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /users or /users.json
  def index
    @users = User.accessible_by(current_ability)
  end

  # GET /users/new
  #Only for staff
  def new
    @user = User.new
  end

  # GET /users/new_admin

  def admin_new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    if user_params[:password] != user_params[:password_confirmation]
      redirect_to new_user_path, notice: "Las contraseñas no coinciden", class:"alert alert-danger"
    else
      if user_params[:branch_id] != nil
        user_data = user_params.merge({:role => "staff"})
      else
        user_data = user_params.merge({:role => "admin"})
      end
      @user = User.new(user_data)
      respond_to do |format|
        if @user.save
          format.html { redirect_to users_path, notice: "El usuario fue correctamente creado." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    #if password confirmation exists, check if passwords match
    if user_params[:password_confirmation] != nil
      if user_params[:password] != user_params[:password_confirmation]
        return redirect_to edit_user_path, notice: "Las contraseñas no coinciden", class:"alert alert-danger"
      end
    end
    user_data= user_params
    respond_to do |format|
      if @user.update(user_data)
        format.html { redirect_to users_path, notice: "El usuario fue actualizado correctamente." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "El usuario fue correctamente borrado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email,:password,:password_confirmation,:branch_id)
    end
end
