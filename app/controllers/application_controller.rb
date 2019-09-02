class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone])
  end

  def after_sign_in_path_for(resource)
    if((current_user.has_role? :tecnhical)||(current_user.has_role? :admin))
      admin_home_index_path
    else
      signout_path
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end