# +Product+ Controller
class ProductsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :product, only: %i[show update destroy]

  # Fetch all +Product+
  # @return [Array] JSON array of all +Product+
  # @example
  #   {
  #     "products":[{
  #       "id":1093,
  #       "product_type":0,
  #       "model":"Incredible Granite Chair",
  #       "price":"2451.25",
  #       "inventory":20,
  #       "high_tech":false,
  #       "rentable":false
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: Product.where(nil),
      search_fields: %i[model]
    )
  end

  # Fetches a given +Product+ element with a given +id+
  # @param id [Integer] +Product+ id
  # @param model [String] Model of product
  # @param price [Decimal] Price in Pesos (MXN)
  # @param inventory [Integer] Amount of products in stock
  # @param product_type [Integer] Specifies type of product
  # @param high_tech [Boolean] Specifies if product is high tech
  # @param rentable [Boolean] Specifies if product can be rented
  # @return [JSON] JSON serialization of found record
  # @example
  #   {
  #     "product":{
  #       "id":1093,
  #       "product_type":0,
  #       "model":"Incredible Granite Chair",
  #       "price":"2451.25",
  #       "inventory":20,
  #       "high_tech":false,
  #       "rentable":false
  #     }
  #   }
  def show
    if @product.nil?
      render json: {}, status: :not_found
    else
      render json: @product
    end
  end

  # Create a new instance of +Product+ and save it to the database
  # @param id [Integer] +Product+ id
  # @param model [String] Model of product
  # @param price [Decimal] Price in Pesos (MXN)
  # @param inventory [Integer] Amount of products in stock
  # @param product_type [Integer] Specifies type of product
  # @param high_tech [Boolean] Specifies if product is high tech
  # @param rentable [Boolean] Specifies if product can be rented
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "product":{
  #       "id":1093,
  #       "product_type":0,
  #       "model":"Incredible Granite Chair",
  #       "price":"2451.25",
  #       "inventory":20,
  #       "high_tech":false,
  #       "rentable":false
  #     }
  #   }
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render_error(product)
    end
  end

  # Update an existing instance of +Product+ and save it to the database
  # @param id [Integer] +Product+ id
  # @param model [String] Model of product
  # @param price [Decimal] Price in Pesos (MXN)
  # @param inventory [Integer] Amount of products in stock
  # @param product_type [Integer] Specifies type of product
  # @param high_tech [Boolean] Specifies if product is high tech
  # @param rentable [Boolean] Specifies if product can be rented
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "product":{
  #       "id":1093,
  #       "product_type":0,
  #       "model":"Updated model",
  #       "price":"2451.25",
  #       "inventory":20,
  #       "high_tech":false,
  #       "rentable":false
  #     }
  #   }
  def update
    if @product.update(product_params)
      render json: @product
    else
      render_error(@product)
    end
  end

  # Destroy an existing instance of +Product+
  # @param id [Integer] +Product+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @product.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def product_params
    params.require(:product).permit(
      :model,
      :price,
      :inventory,
      :product_type,
      :high_tech,
      :rentable
    )
  end

  # Sets model based on param +id+
  def product
    @product ||= Product.find_by(id: params[:id])
  end
end
