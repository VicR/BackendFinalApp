# Module Overrides
module Overrides
  # Devise +RegistrationsController+ overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    protected

    # Devise override for resource creation success serializer
    def render_create_success
      render json: @resource, status: :created
    end

    # Devise override for resource creation error serializer
    def render_create_error
      render_error @resource
    end

    # Devise override for resource creation duplicate email error serializer
    def render_create_error_email_already_exists
      render_error @resource
    end

    # Devise override for resource update success serializer
    def render_update_success
      render json: @resource
    end

    # Devise override for resource update error serializer
    def render_update_error
      render_error @resource
    end

    # Devise override for resource deletion success serializer
    def render_destroy_success
      render json: @resource
    end

    # Devise override for resource deletion error serializer
    def render_destroy_error
      render json: @resource, status: :not_found
    end

    # Devise override for sign up parameters, including to translate fb_token to fb_uid
    def sign_up_params
      params.require(resource_name).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end

    def account_update_params
      params.require(resource_name).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end

    private

    def render_error(mod)
      render json: mod,
             status: :unprocessable_entity,
             serializer: ErrorSerializer,
             adapter: :attributes
    end
  end
end
