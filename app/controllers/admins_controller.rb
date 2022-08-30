class AdminsController < ApplicationController
    before_action :set_admin, only: %i[ show edit update destroy ]

 
  # GET /admins/new
  def new
    @admin = admin.new
  end

  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:email)
    end
end
