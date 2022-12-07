# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can [:index, :show, :create, :update, :destroy], Branch
        can [:index, :show, :create, :update, :destroy], Schedule
        can [:index, :show, :create,:admin_new, :update, :destroy], User
        can [:index, :show, :destroy], Appointment
      elsif user.staff?
        can [:index, :show], Branch
        can [:index, :show], Schedule
        can [:index, :show], User, role: 'user'
        can [:update], User, id: user.id
        can [:index, :show, :update,:destroy], Appointment
      elsif user.user?
        can [:index, :show,:create,:update,:destroy], Appointment, client_id: user.id
        can [:update], User, id: user.id
        
      end
    end
  end
end