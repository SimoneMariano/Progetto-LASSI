class ApplicationController < ActionController::Base
    
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
