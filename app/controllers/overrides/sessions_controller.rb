module Overrides
  # Devise +SessionsController+ overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    protected

    def render_create_success
      render json: @resource, scope: :current_master
    end
  end
end
