# +HighTechProduct+ Controller
class HighTechProductsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :high_tech_product, only: %i[show update destroy]

  # Fetch all +HighTechProduct+
  # @return [Array] JSON array of all +HighTechProduct+
  # @example
  #   {
  #     "high_tech_products":[{
  #       "id":71,
  #       "country":"Japan",
  #       "fabrication_date":"2018-03-09",
  #       "product_id":1069,
  #       "fabricator_id":151
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: HighTechProduct.where(nil),
      search_fields: %i[country fabrication_date]
    )
  end

  # Fetches a given +HighTechProduct+ element with a given +id+
  # @param id [Integer] +HighTechProduct+ id
  # @return [JSON] JSON serialization of found record
  # @example
  #   {
  #     "high_tech_product":{
  #       "id":71,
  #       "country":"Japan",
  #       "fabrication_date":"2018-03-09",
  #       "product_id":1069,
  #       "fabricator_id":151
  #     }
  #   }
  def show
    if @high_tech_product.nil?
      render json: {}, status: :not_found
    else
      render json: @high_tech_product
    end
  end

  # Create a new instance of +HighTechProduct+ and save it to the database
  # @param id [Integer] +HighTechProduct+ id
  # @param country [String] Country of origin
  # @param fabrication_date [Date] Date of fabrication (ISO 8601)
  # @param product_id [Integer] ID of parent +Product+
  # @param fabricator_id [Integer] ID of parent +Fabricator+
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "high_tech_product":{
  #       "id":71,
  #       "country":"Japan",
  #       "fabrication_date":"2018-03-09",
  #       "product_id":1069,
  #       "fabricator_id":151
  #     }
  #   }
  def create
    high_tech_product = HighTechProduct.new(product_params)
    if high_tech_product.save
      render json: high_tech_product, status: :created
    else
      render_error(high_tech_product)
    end
  end

  # Update an existing instance of +HighTechProduct+ and save it to the database
  # @param id [Integer] +HighTechProduct+ id
  # @param country [String] Country of origin
  # @param fabrication_date [Date] Date of fabrication (ISO 8601)
  # @param product_id [Integer] ID of parent +Product+
  # @param fabricator_id [Integer] ID of parent +Fabricator+
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "high_tech_product":{
  #       "id":71,
  #       "country":"Updated country",
  #       "fabrication_date":"2018-03-09",
  #       "product_id":1069,
  #       "fabricator_id":151
  #     }
  #   }
  def update
    if @high_tech_product.update(product_params)
      render json: @high_tech_product
    else
      render_error(@high_tech_product)
    end
  end

  # Destroy an existing instance of +HighTechProduct+
  # @param id [Integer] +HighTechProduct+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @high_tech_product.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def product_params
    params.require(:high_tech_product).permit(
      :country,
      :fabrication_date,
      :product_id,
      :fabricator_id
    )
  end

  # Sets model based on param +id+
  def high_tech_product
    @high_tech_product ||= HighTechProduct.find_by(id: params[:id])
  end
end
