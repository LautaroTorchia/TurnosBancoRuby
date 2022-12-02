class HomeController < ApplicationController
    before_action :authenticate_user!

    def index 
    end

    def about
        @about_me = "Este es el banco de Ruby on Rails. Una organizacion basada en Buenos Aires, Argentina. Somos un banco de primera calidad que ofrece
        una gran confianza a los clientes. Tambien contamos con sucursales en todo el pais. Para mas informacion contactese con nosotros a los siguientes contactos"
    end


    
end
