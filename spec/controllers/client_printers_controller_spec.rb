require 'rails_helper'

RSpec.describe ClientPrintersController, type: :controller do
  let!(:factory_key) { :client_printer }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:client_printers)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:adquisition_date)
      expect(json[0]).to include(:client_id)
    end
  end

  context '#show' do
    let(:client_printer) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: client_printer.id
      }
      json = rest_response_body(:client_printer)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(client_printer.id)
      expect(json[:adquisition_date].to_time.iso8601).to eq(client_printer.adquisition_date.to_time.iso8601)
      expect(json[:client_id]).to eq(client_printer.client.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: client_printer.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:client_printer) { build(:client_printer) }
    it 'valid' do
      process :create, method: :post, params: {
        client_printer: {
          adquisition_date: client_printer.adquisition_date,
          client_id: client_printer.client.id
        }
      }
      json = rest_response_body(:client_printer)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:adquisition_date].to_time.iso8601).to eq(client_printer.adquisition_date.to_time.iso8601)
      expect(json[:client_id]).to eq(client_printer.client.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        client_printer: {
          adquisition_date: client_printer.adquisition_date
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#destroy' do
    let(:client_printer) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: client_printer.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:client_printer)[:id].to_i).to eq(client_printer.id)
    end
  end
end
