class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def authenticate_user!
        if !(admin_signed_in? || user_signed_in?)
            redirect_to new_user_session_path
        end 
    end
    
    def current_user 
        if admin_signed_in?
            current_admin
        else
            super
        end
    end
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to library_path, :alert => exception.message
    end


end
