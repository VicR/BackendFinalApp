# +RentProduct+ Controller
class RentProductsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :rent_product, only: %i[show update destroy]

  # Fetch all +RentProduct+
  # @return [Array] JSON array of all +RentProduct+
  # @example
  #   {
  #     "rent_products":[{
  #       "id":106,
  #       "price_hour":"85.0",
  #       "product_id":1100
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: RentProduct.where(nil),
      search_fields: %i[price_hour]
    )
  end

  # Fetches a given +RentProduct+ element with a given +id+
  # @param id [Integer] +RentProduct+ id
  # @return [JSON] JSON serialization of found record
  # @example
  #   {
  #     "rent_product":{
  #       "id":106,
  #       "price_hour":"85.0",
  #       "product_id":1100
  #     }
  #   }
  def show
    if @rent_product.nil?
      render json: {}, status: :not_found
    else
      render json: @rent_product
    end
  end

  # Create a new instance of +RentProduct+ and save it to the database
  # @param id [Integer] +RentProduct+ id
  # @param price_hour [Decimal] Price per hour of rental
  # @param product_id [Integer] Parent +Product+ id
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "rent_product":{
  #       "id":106,
  #       "price_hour":"85.0",
  #       "product_id":1100
  #     }
  #   }
  def create
    rent_product = RentProduct.new(rent_product_params)
    if rent_product.save
      render json: rent_product, status: :created
    else
      render_error(rent_product)
    end
  end

  # Update an existing instance of +RentProduct+ and save it to the database
  # @param id [Integer] +RentProduct+ id
  # @param price_hour [Decimal] Price per hour of rental
  # @param product_id [Integer]  Parent +Product+ id
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "rent_product":{
  #       "id":106,
  #       "price_hour":"18.2",
  #       "product_id":1100
  #     }
  #   }
  def update
    if @rent_product.update(rent_product_params)
      render json: @rent_product
    else
      render_error(@rent_product)
    end
  end

  # Destroy an existing instance of +RentProduct+
  # @param id [Integer] +RentProduct+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @rent_product.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def rent_product_params
    params.require(:rent_product).permit(
      :price_hour,
      :product_id
    )
  end

  # Sets model based on param +id+
  def rent_product
    @rent_product ||= RentProduct.find_by(id: params[:id])
  end
end
