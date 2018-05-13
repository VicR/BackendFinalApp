class CreateCharacteristics < ActiveRecord::Migration[5.1]
  def change
    create_table :characteristics do |t|
      t.string :field
      t.string :value
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end
