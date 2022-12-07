class ApplicationController < ActionController::Base
    #rescue from cancan exception
    rescue_from CanCan::AccessDenied do |exception|
        render file: "#{Rails.root}/public/403.html", formats: [:html], status: 403, layout: false
    end
end
