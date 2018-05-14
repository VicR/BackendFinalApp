require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:factory_key) { :product }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:products)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:model)
      expect(json[0]).to include(:price)
      expect(json[0]).to include(:inventory)
      expect(json[0]).to include(:product_type)
      expect(json[0]).to include(:high_tech)
      expect(json[0]).to include(:rentable)
    end
  end

  context '#show' do
    let(:product) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: product.id
      }
      json = rest_response_body(:product)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(product.id)
      expect(json[:model]).to eq(product.model)
      expect(json[:price]).to eq(product.price.to_s)
      expect(json[:inventory]).to eq(product.inventory)
      expect(json[:product_type]).to eq(product.product_type)
      expect(json[:high_tech]).to eq(product.high_tech)
      expect(json[:rentable]).to eq(product.rentable)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: product.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:product) { build(:product) }
    it 'valid' do
      process :create, method: :post, params: {
        product: {
          model: product.model,
          price: product.price,
          inventory: product.inventory,
          product_type: product.product_type,
          high_tech: product.high_tech,
          rentable: product.rentable
        }
      }
      json = rest_response_body(:product)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:model]).to eq(product.model)
      expect(json[:price]).to eq(product.price.to_s)
      expect(json[:inventory]).to eq(product.inventory)
      expect(json[:product_type]).to eq(product.product_type)
      expect(json[:high_tech]).to eq(product.high_tech)
      expect(json[:rentable]).to eq(product.rentable)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        product: {
          model: product.model
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:product) { create(:product) }
    it 'valid' do
      model = 'New model'
      process :update, method: :post, params: {
        id: product.id,
        product: {
          model: model
        }
      }
      json = rest_response_body(:product)
      expect(response.status).to eq(200)
      expect(json[:model]).to eq(model)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: product.id,
        product: {
          model: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:product) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: product.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:product)[:id].to_i).to eq(product.id)
    end
  end
end
