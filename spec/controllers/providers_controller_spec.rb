require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  let!(:factory_key) { :provider }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:providers)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:name)
      expect(json[0]).to include(:address)
    end
  end

  context '#show' do
    let(:provider) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: provider.id
      }
      json = rest_response_body(:provider)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(provider.id)
      expect(json[:name]).to eq(provider.name)
      expect(json[:address]).to eq(provider.address)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: provider.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:provider) { build(:provider) }
    it 'valid' do
      process :create, method: :post, params: {
        provider: {
          name: provider.name,
          address: provider.address
        }
      }
      json = rest_response_body(:provider)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:name]).to eq(provider.name)
      expect(json[:address]).to eq(provider.address)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        provider: {
          name: provider.name
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:provider) { create(:provider) }
    it 'valid' do
      name = 'New name'
      process :update, method: :post, params: {
        id: provider.id,
        provider: {
          name: name
        }
      }
      json = rest_response_body(:provider)
      expect(response.status).to eq(200)
      expect(json[:name]).to eq(name)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: provider.id,
        provider: {
          name: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:provider) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: provider.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:provider)[:id].to_i).to eq(provider.id)
    end
  end
end
