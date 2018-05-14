require 'rails_helper'

RSpec.describe ProductAdquisitionsController, type: :controller do
  let!(:factory_key) { :product_adquisition }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:product_adquisitions)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:adquisition_date)
      expect(json[0]).to include(:quantity)
      expect(json[0]).to include(:product_id)
      expect(json[0]).to include(:provider_id)
    end
  end

  context '#show' do
    let(:product_adquisition) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: product_adquisition.id
      }
      json = rest_response_body(:product_adquisition)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(product_adquisition.id)
      expect(json[:adquisition_date].to_time.iso8601).to eq(product_adquisition.adquisition_date.to_time.iso8601)
      expect(json[:quantity]).to eq(product_adquisition.quantity)
      expect(json[:product_id]).to eq(product_adquisition.product.id)
      expect(json[:provider_id]).to eq(product_adquisition.provider.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: product_adquisition.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:product_adquisition) { build(:product_adquisition) }
    it 'valid' do
      process :create, method: :post, params: {
        product_adquisition: {
          adquisition_date: product_adquisition.adquisition_date,
          quantity: product_adquisition.quantity,
          product_id: product_adquisition.product.id,
          provider_id: product_adquisition.provider.id
        }
      }
      json = rest_response_body(:product_adquisition)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:adquisition_date].to_time.iso8601).to eq(product_adquisition.adquisition_date.to_time.iso8601)
      expect(json[:quantity]).to eq(product_adquisition.quantity)
      expect(json[:product_id]).to eq(product_adquisition.product.id)
      expect(json[:provider_id]).to eq(product_adquisition.provider.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        product_adquisition: {
          adquisition_date: product_adquisition.adquisition_date
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:product_adquisition) { create(:product_adquisition) }
    it 'valid' do
      quantity = 70
      process :update, method: :post, params: {
        id: product_adquisition.id,
        product_adquisition: {
          quantity: quantity
        }
      }
      json = rest_response_body(:product_adquisition)
      expect(response.status).to eq(200)
      expect(json[:quantity]).to eq(quantity)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: product_adquisition.id,
        product_adquisition: {
          quantity: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:product_adquisition) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: product_adquisition.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:product_adquisition)[:id].to_i).to eq(product_adquisition.id)
    end
  end
end
