class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  # Allows updates without password unless password or email is changing
  def update_resource(resource, params)
    if params[:password].present? || params[:email] != resource.email
      resource.update_with_password(params)
    else
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :email, :password, :password_confirmation,
      :current_password, :profile_photo, :phone_number, :address
    ])
  end
end
