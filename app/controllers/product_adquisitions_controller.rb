# +ProductAdquisition+ Controller
class ProductAdquisitionsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :product_adquisition, only: %i[show update destroy]

  # Fetch all +ProductAdquisition+
  # @return [Array] JSON array of all +ProductAdquisition+
  # @example
  #   {
  #     "product_adquisitions":[{
  #       "id":163,
  #       "adquisition_date":"2018-03-01T00:00:00.000Z",
  #       "quantity":15,
  #       "product_id":1077,
  #       "provider_id":403
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: ProductAdquisition.where(nil),
      search_fields: %i[adquisition_date]
    )
  end

  # Fetches a given +ProductAdquisition+ element with a given +id+
  # @param id [Integer] +ProductAdquisition+ id
  # @return [JSON] JSON serialization of found record
  # @example
  #   {
  #     "product_adquisition":{
  #       "id":163,
  #       "adquisition_date":"2018-03-01T00:00:00.000Z",
  #       "quantity":15,
  #       "product_id":1077,
  #       "provider_id":403
  #     }
  #   }
  def show
    if @product_adquisition.nil?
      render json: {}, status: :not_found
    else
      render json: @product_adquisition
    end
  end

  # Create a new instance of +ProductAdquisition+ and save it to the database
  # @param id [Integer] +ProductAdquisition+ id
  # @param adquisition_date [Timestamp] Date-time of transaction (ISO 8601)
  # @param quantity [Integer] Amount of products acquired
  # @param product_id [Integer] Parent +Product+ ID
  # @param provider_id [Integer] Parent +Provider+ ID
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "product_adquisition":{
  #       "id":163,
  #       "adquisition_date":"2018-03-01T00:00:00.000Z",
  #       "quantity":15,
  #       "product_id":1077,
  #       "provider_id":403
  #     }
  #   }
  def create
    product_adquisition = ProductAdquisition.new(product_adquisition_params)
    if product_adquisition.save
      render json: product_adquisition, status: :created
    else
      render_error(product_adquisition)
    end
  end

  # Update an existing instance of +ProductAdquisition+ and save it to the database
  # @param id [Integer] +ProductAdquisition+ id
  # @param adquisition_date [Timestamp] Date-time of transaction (ISO 8601)
  # @param quantity [Integer] Amount of products acquired
  # @param product_id [Integer] Parent +Product+ ID
  # @param provider_id [Integer] Parent +Provider+ ID
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "product_adquisition":{
  #       "id":163,
  #       "adquisition_date":"2018-03-01T00:00:00.000Z",
  #       "quantity":70,
  #       "product_id":1077,
  #       "provider_id":403
  #     }
  #   }
  def update
    if @product_adquisition.update(product_adquisition_params)
      render json: @product_adquisition
    else
      render_error(@product_adquisition)
    end
  end

  # Destroy an existing instance of +ProductAdquisition+
  # @param id [Integer] +ProductAdquisition+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @product_adquisition.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def product_adquisition_params
    params.require(:product_adquisition).permit(
      :adquisition_date,
      :quantity,
      :product_id,
      :provider_id
    )
  end

  # Sets model based on param +id+
  def product_adquisition
    @product_adquisition ||= ProductAdquisition.find_by(id: params[:id])
  end
end
