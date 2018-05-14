# +ClientPrinter+ Controller
class ClientPrintersController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :client_printer, only: %i[show update destroy]

  # Fetch all +ClientPrinter+
  # @return [Array] JSON array of all +ClientPrinter+
  # @example
  #   {
  #     "client_printers":[{
  #       "id":81,
  #       "adquisition_date":"2018-04-22T15:53:00.000Z",
  #       "client_id":503
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: ClientPrinter.where(nil),
      search_fields: %i[description total]
    )
  end

  # Fetches a given +ClientPrinter+ element with a given +id+
  # @param id [Integer] +ClientPrinter+ id
  # @return [JSON] JSON serialization of found record
  # @example
  #   {
  #     "client_printer":{
  #       "id":82,
  #       "adquisition_date":"2018-04-22T15:53:00.000Z",
  #       "client_id":504
  #     }
  #   }
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
  # @example
  #   {
  #     "client_printer":{
  #       "id":82,
  #       "adquisition_date":"2018-04-22T15:53:00.000Z",
  #       "client_id":504
  #     }
  #   }
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
  # @example
  #   {
  #     "client_printer":{
  #       "id":82,
  #       "adquisition_date":"2018-05-23T16:00:00.000Z",
  #       "client_id":504
  #     }
  #   }
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
  # @example
  #   {}
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
