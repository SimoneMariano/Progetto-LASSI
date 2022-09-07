class AthenaeumController < ApplicationController
    def index
    end

    def redirect_error(exception)
        redirect_to athenaeum_path, :alert => exception.message
    end

    
end
