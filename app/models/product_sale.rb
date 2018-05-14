# +ProductSale+ Model
class ProductSale < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +ProductSale+ unique ID
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

  # CSV
  # Generates CSV file from all +ProductAdquisition+
  # @param [Hash] options - Optional hash of options thats Ruby's CSV::generate understands
  # @return [File] CSV with data about all +ProductAdquisition+
  def adquisitions_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['ID', 'Fecha', 'Cantidad', 'ID Producto', 'ID Provedor']
      all.find_each do |adq|
        csv << [
          adq.id,
          adq.adquisition_date,
          adq.quantity,
          adq.product_id,
          adq.provider_id
        ]
      end
    end
  end
end
