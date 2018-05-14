# +Characteristic+ Controller
class CharacteristicsController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :characteristic, only: %i[show update destroy]

  # Fetch all +Characteristic+
  # @return [Array] JSON array of all +Characteristic+
  def index
    render_json_api_list_resource(
      collection: Characteristic.where(nil),
      search_fields: %i[field value]
    )
  end

  # Fetches a given +Characteristic+ element with a given +id+
  # @param id [Integer] +Characteristic+ id
  # @return [JSON] JSON serialization of found record
  def show
    if @characteristic.nil?
      render json: {}, status: :not_found
    else
      render json: @characteristic
    end
  end

  # Create a new instance of +Characteristic+ and save it to the database
  # @param id [Integer] +Characteristic+ id
  # @param field [String] Product-specific spec
  # @param value [String] Specific field
  # @param product_id [Integer] Parent +Product+ id
  # @return [JSON] JSON with the object and status code if created or error if not created
  def create
    characteristic = Characteristic.new(characteristic_params)
    if characteristic.save
      render json: characteristic, status: :created
    else
      render_error(characteristic)
    end
  end

  # Update an existing instance of +Characteristic+ and save it to the database
  # @param id [Integer] +Characteristic+ id
  # @param field [String] Product-specific spec
  # @param value [String] Specific field
  # @param product_id [Integer]  Parent +Product+ id
  # @return [JSON] JSON with the object and status code if created or error if not created
  def update
    if @characteristic.update(characteristic_params)
      render json: @characteristic
    else
      render_error(@characteristic)
    end
  end

  # Destroy an existing instance of +Characteristic+
  # @param id [Integer] +Characteristic+ id
  # @return [JSON] Return no content status on success
  def destroy
    render json: @characteristic.destroy, status: :no_content
  end

  protected

  # Allowed parameters
  def characteristic_params
    params.require(:characteristic).permit(
      :field,
      :value,
      :product_id
    )
  end

  # Sets model based on param +id+
  def characteristic
    @characteristic ||= Characteristic.find_by(id: params[:id])
  end
end
