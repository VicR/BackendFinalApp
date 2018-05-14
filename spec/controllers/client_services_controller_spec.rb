require 'rails_helper'

RSpec.describe ClientServicesController, type: :controller do
  let!(:factory_key) { :client_service }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:client_services)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:total)
      expect(json[0]).to include(:description)
      expect(json[0]).to include(:client_id)
    end
  end

  context '#show' do
    let(:client_service) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: client_service.id
      }
      json = rest_response_body(:client_service)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(client_service.id)
      expect(json[:total].to_s).to eq(client_service.total.to_s)
      expect(json[:description]).to eq(client_service.description)
      expect(json[:client_id]).to eq(client_service.client.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: client_service.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:client_service) { build(:client_service) }
    it 'valid' do
      process :create, method: :post, params: {
        client_service: {
          total: client_service.total,
          description: client_service.description,
          client_id: client_service.client.id
        }
      }
      json = rest_response_body(:client_service)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:total].to_s).to eq(client_service.total.to_s)
      expect(json[:description]).to eq(client_service.description)
      expect(json[:client_id]).to eq(client_service.client.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        client_service: {
          total: client_service.total
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:client_service) { create(:client_service) }
    it 'valid' do
      description = 'Updated description'
      process :update, method: :post, params: {
        id: client_service.id,
        client_service: {
          description: description
        }
      }
      json = rest_response_body(:client_service)
      expect(response.status).to eq(200)
      expect(json[:description]).to eq(description)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: client_service.id,
        client_service: {
          description: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:client_service) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: client_service.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:client_service)[:id].to_i).to eq(client_service.id)
    end
  end
end
