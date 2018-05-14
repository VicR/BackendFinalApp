# +ProductSale+ Controller
class ProductSalesController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :product_sale, only: %i[show update destroy]

  # Fetch all +ProductSale+
  # @return [Array] JSON array of all +ProductSale+
  # @example
  #   {
  #     "product_sales":[{
  #       "id":109,
  #       "sale_date":"2017-03-01T00:00:00.000Z",
  #       "quantity":15,
  #       "product_id":1085,
  #       "client_id":524
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: ProductSale.where(nil),
      search_fields: %i[adquisition_date]
    )
  end

  # Fetches a given +ProductSale+ element with a given +id+
  # @param id [Integer] +ProductSale+ id
  # @return [JSON] JSON serialization of found record# @example
  # @example
  #   {
  #     "product_sale":{
  #       "id":109,
  #       "sale_date":"2017-03-01T00:00:00.000Z",
  #       "quantity":15,
  #       "product_id":1085,
  #       "client_id":524
  #     }
  #   }
  def show
    if @product_sale.nil?
      render json: {}, status: :not_found
    else
      render json: @product_sale
    end
  end

  # Create a new instance of +ProductSale+ and save it to the database
  # @param id [Integer] +ProductSale+ id
  # @param sale_date [Timestamp] Date-time of sale (ISO 8601)
  # @param quantity [Integer] Amount of products acquired
  # @param product_id [Integer] Parent +Product+ ID
  # @param client_id [Integer] Parent +Client+ ID
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "product_sale":{
  #       "id":109,
  #       "sale_date":"2017-03-01T00:00:00.000Z",
  #       "quantity":15,
  #       "product_id":1085,
  #       "client_id":524
  #     }
  #   }
  def create
    product_sale = ProductSale.new(product_sale_params)
    if product_sale.save
      render json: product_sale, status: :created
    else
      render_error(product_sale)
    end
  end

  # Update an existing instance of +ProductSale+ and save it to the database
  # @param id [Integer] +ProductSale+ id
  # @param sale_date [Timestamp] Date-time of sale (ISO 8601)
  # @param quantity [Integer] Amount of products acquired
  # @param product_id [Integer] Parent +Product+ ID
  # @param client_id [Integer] Parent +Client+ ID
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "product_sale":{
  #       "id":109,
  #       "sale_date":"2017-03-01T00:00:00.000Z",
  #       "quantity":70,
  #       "product_id":1085,
  #       "client_id":524
  #     }
  #   }
  def update
    if @product_sale.update(product_sale_params)
      render json: @product_sale
    else
      render_error(@product_sale)
    end
  end

  # Destroy an existing instance of +ProductSale+
  # @param id [Integer] +ProductSale+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @product_sale.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def product_sale_params
    params.require(:product_sale).permit(
      :sale_date,
      :quantity,
      :product_id,
      :client_id
    )
  end

  # Sets model based on param +id+
  def product_sale
    @product_sale ||= ProductSale.find_by(id: params[:id])
  end
end
