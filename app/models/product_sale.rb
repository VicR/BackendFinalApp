# +ProductSale+ Model
class ProductSale < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +ProductAdquisition+ unique ID
  # @!attribute sale_date
  #   @return [Timestamp] Date-time of sale (ISO 8601)
  # @!attribute quantity
  #   @return [Integer] Amount of products acquired
  # @!attribute product_id
  #   @return [Integer] Parent +Product+ id
  # @!attribute client_id
  #   @return [Integer] Parent +Client+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  belongs_to :product
  belongs_to :client

  # validations
  validates :sale_date, presence: true
  validates :quantity, presence: true, numericality: true
end
