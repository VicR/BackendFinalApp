module Overrides
  # Devise +TokenValidationsController+ overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    def validate_token
      super do |resource|
        render_validate_token_error && return unless resource.active_for_authentication?
      end
    end

    protected

    def render_validate_token_success
      render json: @resource
    end

    def render_validate_token_error
      render json: {}, status: :unauthorized
    end
  end
end
