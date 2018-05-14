# +Fabricator+ Model
class Fabricator < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Fabricator+ unique ID
  # @!attribute name
  #   @return [String] Name of of fabricator
  # @!attribute address
  #   @return [String] Address
  # @!attribute employee_qty
  #   @return [Integer] Number of employees hired
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  has_many :high_tech_products, dependent: :destroy

  # validations
  validates :name,
            :address, presence: true
  validates :employee_qty, presence: true, numericality: true

  # CSV
  # Generates CSV file from all +Fabricator+
  # @param [Hash] options - Optional hash of options thats Ruby's CSV::generate understands
  # @return [File] CSV with data about all +Fabricator+
  def fabricators_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['Nombre', 'Dirección', 'No. Empleados']
      all.find_each do |fabricator|
        csv << [
          fabricator.id,
          fabricator.name,
          fabricator.address,
          fabricator.employee_qty.to_s
        ]
        fabricator.high_tech_products.find_each do |prod|
          csv << ['Productos de Alta Tecnología']
          csv << ['ID', 'País', 'Fecha Fabricación']
          csv << [
            prod.id,
            prod.country,
            prod.fabrication_date
          ]
        end
      end
    end
  end
end
