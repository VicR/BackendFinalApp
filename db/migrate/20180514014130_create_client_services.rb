class CreateClientServices < ActiveRecord::Migration[5.1]
  def change
    create_table :client_services do |t|
      t.timestamp :adquisition_date

      t.belongs_to :client

      t.timestamps
    end
  end
end
