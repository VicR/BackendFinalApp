class CreateClientPrinters < ActiveRecord::Migration[5.1]
  def change
    create_table :client_printers do |t|
      t.timestamp :adquisition_date

      t.belongs_to :client

      t.timestamps
    end
  end
end
