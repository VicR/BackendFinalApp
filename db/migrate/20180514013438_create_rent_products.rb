class CreateRentProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :rent_products do |t|
      t.decimal :price_hour

      t.belongs_to :product

      t.timestamps
    end
  end
end
