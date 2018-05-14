class ModifyClientServices < ActiveRecord::Migration[5.1]
  def change
    remove_column :client_services, :adquisition_date, :date
    add_column :client_services, :description, :string
    add_column :client_services, :total, :decimal
  end
end
