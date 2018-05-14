class UpdateClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :name, :string
    add_column :clients, :fathers_last, :string
    add_column :clients, :mothers_last, :string
    add_column :clients, :ine, :string
    add_column :clients, :phone, :string
    add_column :clients, :address, :string
    add_reference :clients, :user
  end
end
