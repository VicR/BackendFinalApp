class CreateProductSales < ActiveRecord::Migration[5.1]
  def change
    create_table :product_sales do |t|
      t.timestamp :sale_date
      t.integer :quantity

      t.belongs_to :product
      t.belongs_to :client

      t.timestamps
    end
  end
end
