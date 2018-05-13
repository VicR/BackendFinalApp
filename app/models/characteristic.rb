# +Characteristic+ Model
class Characteristic < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Characteristic+ unique ID
  # @!attribute field
  #   @return [String] Product-specific spec
  # @!attribute value
  #   @return [String] Spec of field
  # @!attribute product_id
  #   @return [Integer] Parent +Product+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date
  # relations
  belongs_to :product

  # validations
  validates :field,
            :value, presence: true
end
