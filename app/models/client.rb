# +Client+ Model
class Client < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Client+ unique ID
  # @!attribute name
  #   @return [String] First name
  # @!attribute fathers_last
  #   @return [String] Father's last name
  # @!attribute mothers_last
  #   @return [String] Mother's last name
  # @!attribute ine
  #   @return [String] INE digits
  # @!attribute phone
  #   @return [String] Phone number
  # @!attribute address
  #   @return [String] Home address
  # @!attribute user_id
  #   @return [Integer] Parent +User+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date
  # relations
  belongs_to :user
  has_many :client_services, dependent: :destroy
  has_many :client_printers, dependent: :destroy
  has_many :product_sales, dependent: :destroy

  # validations
  validates :name,
            :fathers_last,
            :mothers_last,
            :ine,
            :phone,
            :address, presence: true

  # functions
  def full_name
    full_name = name
    full_name = "#{full_name} #{fathers_last}" if fathers_last.present?
    full_name = "#{full_name} #{mothers_last}" if mothers_last.present?
    full_name
  end

  # CSV
  # Generates CSV file from all +Clients+
  # @param [Hash] options - Optional hash of options thats Ruby's CSV::generate understands
  # @return [File] CSV with data about all +Clients+
  def clients_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['Name', 'INE', 'Phone', 'Address']
      all.find_each do |client|
        csv << [
          client.full_name,
          client.ine,
          client.phone,
          client.address
        ]
        client.client_services.find_each do |service|
          csv << [
            service.id,
            service.description,
            service.total.to_s
          ]
        end
        client.client_printers.find_each do |printer|
          csv << [
            printer.id,
            printer.adquisition_date
          ]
        end
        client.product_sales.find_each do |sale|
          csv << [
            sale.id,
            sale.sale_date,
            sale.quantity
          ]
        end
      end
    end
  end
end
