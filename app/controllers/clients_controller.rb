# +Client+ Controller
class ClientsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :client, only: %i[show update destroy]

  # Fetch all +Client+
  # @return [Array] JSON array of all +Client+
  def index
    render_json_api_list_resource(
      collection: Client.where(nil),
      search_fields: %i[name]
    )
  end

  # Fetches a given +Client+ element with a given +id+
  # @param id [Integer] +Client+ id
  # @return [JSON] JSON serialization of found record
  def show
    if @client.nil?
      render json: {}, status: :not_found
    else
      render json: @client
    end
  end

  # Create a new instance of +Client+ and save it to the database
  # @param id [Integer] +Client+ id
  # @param name [String] First name
  # @param fathers_last [String] Father's last name
  # @param mothers_last [String] Mother's last name
  # @param ine [String] INE digits
  # @param phone [String] Phone number
  # @param address [String] Home address
  # @param user_id [Integer] Parent +User+ id
  # @return [JSON] JSON with the object and status code if created or error if not created
  def create
    client = Client.new(client_params)
    if client.save
      render json: client, status: :created
    else
      render_error(client)
    end
  end

  # Update an existing instance of +Client+ and save it to the database
  # @param id [Integer] +Client+ id
  # @param name [String] First name
  # @param fathers_last [String] Father's last name
  # @param mothers_last [String] Mother's last name
  # @param ine [String] INE digits
  # @param phone [String] Phone number
  # @param address [String] Home address
  # @param user_id [Integer] Parent +User+ id
  # @return [JSON] JSON with the object and status code if created or error if not created
  def update
    if @client.update(client_params)
      render json: @client
    else
      render_error(@client)
    end
  end

  # Destroy an existing instance of +Client+
  # @param id [Integer] +Client+ id
  # @return [JSON] Return no content status on success
  def destroy
    render json: @client.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def client_params
    params.require(:client).permit(
      :name,
      :fathers_last,
      :mothers_last,
      :ine,
      :phone,
      :address,
      :user_id
    )
  end

  # Sets model based on param +id+
  def client
    @client ||= Client.find_by(id: params[:id])
  end
end