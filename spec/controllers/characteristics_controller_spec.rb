require 'rails_helper'

RSpec.describe CharacteristicsController, type: :controller do
  let!(:factory_key) { :characteristic }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:characteristics)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:field)
      expect(json[0]).to include(:value)
      expect(json[0]).to include(:product_id)
    end
  end

  context '#show' do
    let(:characteristic) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: characteristic.id
      }
      json = rest_response_body(:characteristic)
      expect(response.status).to eq(200)
      expect(json[:field]).to eq(characteristic.field)
      expect(json[:value]).to eq(characteristic.value)
      expect(json[:product_id]).to eq(characteristic.product.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: characteristic.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:characteristic) { build(:characteristic) }
    it 'valid' do
      process :create, method: :post, params: {
        characteristic: {
          field: characteristic.field,
          value: characteristic.value,
          product_id: characteristic.product.id
        }
      }
      json = rest_response_body(:characteristic)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:field]).to eq(characteristic.field)
      expect(json[:value]).to eq(characteristic.value)
      expect(json[:product_id]).to eq(characteristic.product.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        characteristic: {
          value: characteristic.value
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:characteristic) { create(:characteristic) }
    it 'valid' do
      value = 'New value'
      process :update, method: :post, params: {
        id: characteristic.id,
        characteristic: {
          value: value
        }
      }
      json = rest_response_body(:characteristic)
      expect(response.status).to eq(200)
      expect(json[:value]).to eq(value)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: characteristic.id,
        characteristic: {
          value: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:characteristic) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: characteristic.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:characteristic)[:id].to_i).to eq(characteristic.id)
    end
  end
end
