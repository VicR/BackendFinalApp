# +ClientService+ Model
class ClientService < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +ClientService+ unique ID
  # @!attribute description
  #   @return [String] Description of service provided
  # @!attribute total
  #   @return [Decimal] Total amount
  # @!attribute client_id
  #   @return [Integer] Parent +Client+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  belongs_to :client

  # validations
  validates :description,
            :total, presence: true
end
