require 'rails_helper'

RSpec.describe HighTechProductsController, type: :controller do
  let!(:factory_key) { :high_tech_product }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:high_tech_products)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:fabrication_date)
      expect(json[0]).to include(:country)
      expect(json[0]).to include(:product_id)
      expect(json[0]).to include(:fabricator_id)
    end
  end

  context '#show' do
    let(:high_tech_product) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: high_tech_product.id
      }
      json = rest_response_body(:high_tech_product)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(high_tech_product.id)
      expect(json[:fabrication_date].to_time.iso8601).to eq(high_tech_product.fabrication_date.to_time.iso8601)
      expect(json[:country]).to eq(high_tech_product.country)
      expect(json[:product_id]).to eq(high_tech_product.product.id)
      expect(json[:fabricator_id]).to eq(high_tech_product.fabricator.id)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: high_tech_product.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:high_tech_product) { build(:high_tech_product) }
    it 'valid' do
      process :create, method: :post, params: {
        high_tech_product: {
          fabrication_date: high_tech_product.fabrication_date,
          country: high_tech_product.country,
          product_id: high_tech_product.product.id,
          fabricator_id: high_tech_product.fabricator.id
        }
      }
      json = rest_response_body(:high_tech_product)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:fabrication_date].to_time.iso8601).to eq(high_tech_product.fabrication_date.to_time.iso8601)
      expect(json[:country]).to eq(high_tech_product.country)
      expect(json[:product_id]).to eq(high_tech_product.product.id)
      expect(json[:fabricator_id]).to eq(high_tech_product.fabricator.id)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        high_tech_product: {
          fabrication_date: high_tech_product.fabrication_date
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:high_tech_product) { create(:high_tech_product) }
    it 'valid' do
      country = 'Updated country'
      process :update, method: :post, params: {
        id: high_tech_product.id,
        high_tech_product: {
          country: country
        }
      }
      json = rest_response_body(:high_tech_product)
      expect(response.status).to eq(200)
      expect(json[:country]).to eq(country)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: high_tech_product.id,
        high_tech_product: {
          country: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:high_tech_product) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: high_tech_product.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:high_tech_product)[:id].to_i).to eq(high_tech_product.id)
    end
  end
end
