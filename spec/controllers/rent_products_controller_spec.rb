require 'rails_helper'

RSpec.describe RentProductsController, type: :controller do
  let!(:factory_key) { :rent_product }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:rent_products)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:price_hour)
      expect(json[0]).to include(:product_id)
    end
  end

  context '#show' do
    let(:rent_product) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: rent_product.id
      }
      json = rest_response_body(:rent_product)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(rent_product.id)
      expect(json[:price_hour].to_s).to eq(rent_product.price_hour.to_s)
      expect(json[:product_id]).to eq(rent_product.product.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: rent_product.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:rent_product) { build(:rent_product) }
    it 'valid' do
      process :create, method: :post, params: {
        rent_product: {
          price_hour: rent_product.price_hour,
          product_id: rent_product.product.id
        }
      }
      json = rest_response_body(:rent_product)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:price_hour].to_s).to eq(rent_product.price_hour.to_s)
      expect(json[:product_id]).to eq(rent_product.product.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        rent_product: {
          price_hour: rent_product.price_hour
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:rent_product) { create(:rent_product) }
    it 'valid' do
      price_hour = 18.2
      process :update, method: :post, params: {
        id: rent_product.id,
        rent_product: {
          price_hour: price_hour
        }
      }
      json = rest_response_body(:rent_product)
      expect(response.status).to eq(200)
      expect(json[:price_hour].to_s).to eq(price_hour.to_s)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: rent_product.id,
        rent_product: {
          price_hour: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:rent_product) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: rent_product.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:rent_product)[:id].to_i).to eq(rent_product.id)
    end
  end
end
