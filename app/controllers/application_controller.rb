class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    
    
    rescue_from CanCan::AccessDenied do |exception|
        
        if ["book_scraper", "categories", "authors", "book_rentals", "secondhands", "books","courses"].include?(controller_name)
            redirect_to library_path, :alert => exception.message
            
        else
            redirect_to athenaeum_path, :alert => exception.message
        end
    end

   

    
   
    


end
