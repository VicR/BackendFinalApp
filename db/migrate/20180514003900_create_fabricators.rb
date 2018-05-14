class CreateFabricators < ActiveRecord::Migration[5.1]
  def change
    create_table :fabricators do |t|
      t.string :name
      t.string :address
      t.integer :employee_qty

      t.timestamps
    end
  end
end
