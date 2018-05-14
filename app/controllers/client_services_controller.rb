# +ClientService+ Controller
class ClientServicesController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :client_service, only: %i[show update destroy]

  # Fetch all +ClientService+
  # @return [Array] JSON array of all +ClientService+
  def index
    render_json_api_list_resource(
      collection: ClientService.where(nil),
      search_fields: %i[adquisition_date]
    )
  end

  # Fetches a given +ClientService+ element with a given +id+
  # @param id [Integer] +ClientService+ id
  # @return [JSON] JSON serialization of found record
  def show
    if @client_service.nil?
      render json: {}, status: :not_found
    else
      render json: @client_service
    end
  end

  # Create a new instance of +ClientService+ and save it to the database
  # @param id [Integer] +ClientService+ id
  # @param adquisition_date [Timestamp] Date-time of printer adquisition
  # @param client_id [Integer] ID of parent +Client+
  # @return [JSON] JSON with the object and status code if created or error if not created
  def create
    client_service = ClientService.new(client_service_params)
    if client_service.save
      render json: client_service, status: :created
    else
      render_error(client_service)
    end
  end

  # Update an existing instance of +ClientService+ and save it to the database
  # @param id [Integer] +ClientService+ id
  # @param adquisition_date [Timestamp] Date-time of printer adquisition
  # @param client_id [Integer] ID of parent +Client+
  # @return [JSON] JSON with the object and status code if created or error if not created
  def update
    if @client_service.update(client_service_params)
      render json: @client_service
    else
      render_error(@client_service)
    end
  end

  # Destroy an existing instance of +ClientService+
  # @param id [Integer] +ClientService+ id
  # @return [JSON] Return no content status on success
  def destroy
    render json: @client_service.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def client_service_params
    params.require(:client_service).permit(
      :adquisition_date,
      :client_id
    )
  end

  # Sets model based on param +id+
  def client_service
    @client_service ||= ClientService.find_by(id: params[:id])
  end
end
