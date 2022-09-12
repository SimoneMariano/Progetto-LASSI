class UsersController < ApplicationController
    before_action :set_user, only: %i[ show destroy create]
    skip_before_action :authenticate_user!

    def index
      authenticated
    end

   

    


    def new 
        @user = User.new(params[:user])
        
    end

    def edit
      authenticated
      @user = current_user
    end

    def update
      @user = current_user

      if params[:course_id].present?
        @user.course_id = params[:course_id]
      end
  
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

    
    def setSession(id)
      session[:user_id] = id
      @current_user ||= User.find(session[:user_id])
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

    def authenticated
      if user_signed_in?
        if current_user.admin?
          redirect_to home_path
        else
          @user = current_user
        end
      else
        redirect_to login_path
      end
    end
end
