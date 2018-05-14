class CreateHighTechProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :high_tech_products do |t|
      t.string :country
      t.date :fabrication_date

      t.belongs_to :product
      t.belongs_to :fabricator

      t.timestamps
    end
  end
end
