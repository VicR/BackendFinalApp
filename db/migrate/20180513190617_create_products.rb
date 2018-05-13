class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :product_type
      t.string :model
      t.decimal :price
      t.integer :inventory
      t.boolean :high_tech
      t.boolean :rentable

      t.timestamps
    end
  end
end
