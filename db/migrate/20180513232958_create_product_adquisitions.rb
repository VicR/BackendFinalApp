class CreateProductAdquisitions < ActiveRecord::Migration[5.1]
  def change
    create_table :product_adquisitions do |t|
      t.timestamp :adquisition_date
      t.integer :quantity

      t.belongs_to :product
      t.belongs_to :provider

      t.timestamps
    end
  end
end
