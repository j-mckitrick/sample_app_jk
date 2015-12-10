class Auth::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def new
    build_resource()
    resource.build_developer_profile
  end

  def create
    # add custom create logic here
    session[:developer]=nil
    build_resource(resource_params)
    
    User.transaction do
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, (params[:event_token].present? ? :signed_up_and_bid : :signed_up) if is_navigational_format?
          sign_up(resource_name, resource)
          respond_to do |format|
            format.html { respond_with resource, :location => after_sign_in_path_for(resource, params[:r]) }
            format.js { render partial: "shared/create_account", user: resource }
          end
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_to do |format|
            format.html { respond_with resource, :location => after_inactive_sign_up_path_for(resource) }
          end
        end
      else
        clean_up_passwords resource
        flash.now[:error] = "Your account was not created. Please address the errors listed below and try again: <br/><br/><span>#{resource.errors.full_messages.join('<br>')}</span>"
      
        respond_to do |format|
          format.html { 
            render "/devise/registrations/new", locals: { user: resource }
          }
          format.js { render partial: "shared/create_account", user: resource }
        end
      
      end
    end
  end

  protected
    DEVELOPER_PROFILE_ATTRIBUTES = [:employment, :experience, :yearly_projects, :typical_project_size, :how_did_you_hear, :how_response]
    ACCEPTED_ATTRIBUTES=[:name, :email, :password, :current_password, :phone_number, address_attributes: [:city, :state], developer_profile_attributes: DEVELOPER_PROFILE_ATTRIBUTES]
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(ACCEPTED_ATTRIBUTES) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(ACCEPTED_ATTRIBUTES) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
    end

    def resource_params
      params.require(:user).permit(ACCEPTED_ATTRIBUTES)
    end
  private :resource_params
end