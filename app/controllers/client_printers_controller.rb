# +ClientPrinter+ Controller
class ClientPrintersController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :client_printer, only: %i[show update destroy]

  # Fetch all +ClientPrinter+
  # @return [Array] JSON array of all +ClientPrinter+
  def index
    render_json_api_list_resource(
      collection: ClientPrinter.where(nil),
      search_fields: %i[description total]
    )
  end

  # Fetches a given +ClientPrinter+ element with a given +id+
  # @param id [Integer] +ClientPrinter+ id
  # @return [JSON] JSON serialization of found record
  def show
    if @client_printer.nil?
      render json: {}, status: :not_found
    else
      render json: @client_printer
    end
  end

  # Create a new instance of +ClientPrinter+ and save it to the database
  # @param id [Integer] +ClientPrinter+ id
  # @param adquisition_date [Timestamp] Date-time of printer adquisition
  # @param client_id [Integer] ID of parent +Client+
  # @return [JSON] JSON with the object and status code if created or error if not created
  def create
    client_printer = ClientPrinter.new(client_printer_params)
    if client_printer.save
      render json: client_printer, status: :created
    else
      render_error(client_printer)
    end
  end

  # Update an existing instance of +ClientPrinter+ and save it to the database
  # @param id [Integer] +ClientPrinter+ id
  # @param adquisition_date [Timestamp] Date-time of printer adquisition
  # @param client_id [Integer] ID of parent +Client+
  # @return [JSON] JSON with the object and status code if created or error if not created
  def update
    if @client_printer.update(client_printer_params)
      render json: @client_printer
    else
      render_error(@client_printer)
    end
  end

  # Destroy an existing instance of +ClientPrinter+
  # @param id [Integer] +ClientPrinter+ id
  # @return [JSON] Return no content status on success
  def destroy
    render json: @client_printer.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def client_printer_params
    params.require(:client_printer).permit(
      :adquisition_date,
      :client_id
    )
  end

  # Sets model based on param +id+
  def client_printer
    @client_printer ||= ClientPrinter.find_by(id: params[:id])
  end
end
