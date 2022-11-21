class HomeController < ApplicationController
    before_action :authenticate_user!

    def index 
    end

    def about
        @about_me = "Este es el banco de Ruby on Rails"
    end


    
end
