class ApplicationController < ActionController::Base
    
    protect_from_forgery with: :exception
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_in_path_for(resource)
        
   # @user.clinic_id = params[:clinic_id]
      user_path(current_user) 
    end
	
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:fname, :lname, :username, :birthday, :email, :clinic_id, :password, :remember_me)}
        devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:fname, :lname, :username, :birthday, :email, :clinic_id, :password, :current_password, :remember_me)}
    end
end
