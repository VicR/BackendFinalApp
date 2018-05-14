require 'rails_helper'

RSpec.describe ProductSalesController, type: :controller do
  let!(:factory_key) { :product_sale }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:product_sales)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:sale_date)
      expect(json[0]).to include(:quantity)
      expect(json[0]).to include(:product_id)
      expect(json[0]).to include(:client_id)
    end
  end

  context '#show' do
    let(:product_sale) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: product_sale.id
      }
      json = rest_response_body(:product_sale)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(product_sale.id)
      expect(json[:sale_date].to_time.iso8601).to eq(product_sale.sale_date.to_time.iso8601)
      expect(json[:quantity]).to eq(product_sale.quantity)
      expect(json[:product_id]).to eq(product_sale.product.id)
      expect(json[:client_id]).to eq(product_sale.client.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: product_sale.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:product_sale) { build(:product_sale) }
    it 'valid' do
      process :create, method: :post, params: {
        product_sale: {
          sale_date: product_sale.sale_date,
          quantity: product_sale.quantity,
          product_id: product_sale.product.id,
          client_id: product_sale.client.id
        }
      }
      json = rest_response_body(:product_sale)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:sale_date].to_time.iso8601).to eq(product_sale.sale_date.to_time.iso8601)
      expect(json[:quantity]).to eq(product_sale.quantity)
      expect(json[:product_id]).to eq(product_sale.product.id)
      expect(json[:client_id]).to eq(product_sale.client.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        product_sale: {
          sale_date: product_sale.sale_date
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:product_sale) { create(:product_sale) }
    it 'valid' do
      quantity = 70
      process :update, method: :post, params: {
        id: product_sale.id,
        product_sale: {
          quantity: quantity
        }
      }
      json = rest_response_body(:product_sale)
      expect(response.status).to eq(200)
      expect(json[:quantity]).to eq(quantity)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: product_sale.id,
        product_sale: {
          quantity: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:product_sale) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: product_sale.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:product_sale)[:id].to_i).to eq(product_sale.id)
    end
  end
end
