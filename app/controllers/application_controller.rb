# ApplicationController
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApiListable

  def render_error(mod)
    render json: mod,
           status: :unprocessable_entity,
           adapter: :attributes,
           serializer: ErrorSerializer
  end
end
