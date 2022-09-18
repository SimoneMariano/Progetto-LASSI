class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def authenticate_user! 
        if user_signed_in?
            super
        else      
            redirect_to login_path, :alert => 'You need to sign in or sign up before continuing.'
                
        end        
    end

    
    
    rescue_from CanCan::AccessDenied do |exception|
        
        if ["book_scraper", "categories", "authors", "book_rentals", "secondhands", "books","courses"].include?(controller_name)
            redirect_to library_path, :alert => exception.message
            
        else
            redirect_to athenaeum_path, :alert => exception.message
        end
    end

    rescue_from Google::Apis::AuthorizationError do |exception|
        reset_session
        flash[:alert] = "Session expired, you have to log in again"
        redirect_to login_path

    end



end
