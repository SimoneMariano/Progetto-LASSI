class UsersController < ApplicationController
    before_action :set_user, only: %i[ show destroy]
    skip_before_action :authenticate_user!

    def index
      if user_signed_in?
        if current_user.admin?
          redirect_to home_path
        else
          @user = current_user
        end
      else
        redirect_to new_session_path
      end
    end


    def new 
        @user = User.new(params[:user])
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      @user.course_id = params[:course_id]
  
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to profile_path, notice: "user was successfully updated, wait for new approvation." }
          format.json { render :index, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :surname, :image, :course_id, :matricola, :email)
    end
end
