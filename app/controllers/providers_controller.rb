# +Provider+ Controller
class ProvidersController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :provider, only: %i[show update destroy]

  # Fetch all +Provider+
  # @return [Array] JSON array of all +Provider+
  def index
    render_json_api_list_resource(
      collection: Provider.where(nil),
      search_fields: %i[name]
    )
  end

  # Fetches a given +Provider+ element with a given +id+
  # @param id [Integer] +Provider+ id
  # @return [JSON] JSON serialization of found record
  def show
    if @provider.nil?
      render json: {}, status: :not_found
    else
      render json: @provider
    end
  end

  # Create a new instance of +Provider+ and save it to the database
  # @param id [Integer] +Provider+ id
  # @param name [String] Name of provider
  # @param address [String] Address
  # @return [JSON] JSON with the object and status code if created or error if not created
  def create
    provider = Provider.new(provider_params)
    if provider.save
      render json: provider, status: :created
    else
      render_error(provider)
    end
  end

  # Update an existing instance of +Provider+ and save it to the database
  # @param id [Integer] +Provider+ id
  # @param name [String] Name of provider
  # @param address [String] Address
  # @return [JSON] JSON with the object and status code if created or error if not created
  def update
    if @provider.update(provider_params)
      render json: @provider
    else
      render_error(@provider)
    end
  end

  # Destroy an existing instance of +Provider+
  # @param id [Integer] +Provider+ id
  # @return [JSON] Return no content status on success
  def destroy
    render json: @provider.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def provider_params
    params.require(:provider).permit(
      :name,
      :address
    )
  end

  # Sets model based on param +id+
  def provider
    @provider ||= Provider.find_by(id: params[:id])
  end
end
