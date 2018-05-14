# +Fabricator+ Controller
class FabricatorsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :fabricator, only: %i[show update destroy]

  # Fetch all +Fabricator+
  # @return [Array] JSON array of all +Fabricator+# @example
  # @example
  #   {
  #     "fabricators":[{
  #       "id":144,
  #       "name":"Asus",
  #       "address":"50 Asus Road. Asus",
  #       "employee_qty":123
  #     }],
  #     "meta":{
  #       "itemsCount":1,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: Fabricator.where(nil),
      search_fields: %i[name]
    )
  end

  # Fetches a given +Fabricator+ element with a given +id+
  # @param id [Integer] +Fabricator+ id
  # @return [JSON] JSON serialization of found record# @example
  # @example
  #   {
  #     "fabricator":{
  #       "id":144,
  #       "name":"Asus",
  #       "address":"50 Asus Road. Asus",
  #       "employee_qty":123
  #     }
  #   }
  def show
    if @fabricator.nil?
      render json: {}, status: :not_found
    else
      render json: @fabricator
    end
  end

  # Create a new instance of +Fabricator+ and save it to the database
  # @param id [Integer] +Fabricator+ id
  # @param name [String] Name of fabricator
  # @param address [String] Address
  # @param employee_qty [Integer] Number of employees hired
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "fabricator":{
  #       "id":144,
  #       "name":"Asus",
  #       "address":"50 Asus Road. Asus",
  #       "employee_qty":123
  #     }
  #   }
  def create
    fabricator = Fabricator.new(fabricator_params)
    if fabricator.save
      render json: fabricator, status: :created
    else
      render_error(fabricator)
    end
  end

  # Update an existing instance of +Fabricator+ and save it to the database
  # @param id [Integer] +Fabricator+ id
  # @param name [String] Name of fabricator
  # @param address [String] Address
  # @param employee_qty [Integer] Number of employees hired
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "fabricator":{
  #       "id":144,
  #       "name":"Updated name",
  #       "address":"50 Asus Road. Asus",
  #       "employee_qty":123
  #     }
  #   }
  def update
    if @fabricator.update(fabricator_params)
      render json: @fabricator
    else
      render_error(@fabricator)
    end
  end

  # Destroy an existing instance of +Fabricator+
  # @param id [Integer] +Fabricator+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @fabricator.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def fabricator_params
    params.require(:fabricator).permit(
      :name,
      :address,
      :employee_qty
    )
  end

  # Sets model based on param +id+
  def fabricator
    @fabricator ||= Fabricator.find_by(id: params[:id])
  end
end
