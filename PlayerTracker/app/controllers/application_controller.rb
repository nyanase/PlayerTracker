class ApplicationController < ActionController::Base

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name) }
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name) }
end
end
