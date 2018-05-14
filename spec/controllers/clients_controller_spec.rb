require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  let!(:factory_key) { :client }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:clients)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:name)
      expect(json[0]).to include(:fathers_last)
      expect(json[0]).to include(:mothers_last)
      expect(json[0]).to include(:ine)
      expect(json[0]).to include(:phone)
      expect(json[0]).to include(:address)
      expect(json[0]).to include(:user_id)
    end
  end

  context '#show' do
    let(:client) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: client.id
      }
      json = rest_response_body(:client)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(client.id)
      expect(json[:name]).to eq(client.name)
      expect(json[:fathers_last]).to eq(client.fathers_last.to_s)
      expect(json[:mothers_last]).to eq(client.mothers_last)
      expect(json[:ine]).to eq(client.ine)
      expect(json[:phone]).to eq(client.phone)
      expect(json[:address]).to eq(client.address)
      expect(json[:user_id]).to eq(client.user.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: client.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:client) { build(:client) }
    it 'valid' do
      process :create, method: :post, params: {
        client: {
          name: client.name,
          fathers_last: client.fathers_last,
          mothers_last: client.mothers_last,
          ine: client.ine,
          phone: client.phone,
          address: client.address,
          user_id: client.user.id
        }
      }
      json = rest_response_body(:client)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:name]).to eq(client.name)
      expect(json[:fathers_last]).to eq(client.fathers_last.to_s)
      expect(json[:mothers_last]).to eq(client.mothers_last)
      expect(json[:ine]).to eq(client.ine)
      expect(json[:phone]).to eq(client.phone)
      expect(json[:address]).to eq(client.address)
      expect(json[:user_id]).to eq(client.user.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        client: {
          name: client.name
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:client) { create(:client) }
    it 'valid' do
      name = 'New name'
      process :update, method: :post, params: {
        id: client.id,
        client: {
          name: name
        }
      }
      json = rest_response_body(:client)
      expect(response.status).to eq(200)
      expect(json[:name]).to eq(name)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: client.id,
        client: {
          name: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:client) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: client.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:client)[:id].to_i).to eq(client.id)
    end
  end
end
