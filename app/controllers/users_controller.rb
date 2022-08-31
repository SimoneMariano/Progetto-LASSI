class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy]
    skip_before_action :authenticate_user!

    def new 
        @user = User.new(params[:user])
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:matricola, :email)
    end
end
