require 'rails_helper'

RSpec.describe FabricatorsController, type: :controller do
  let!(:factory_key) { :fabricator }
  before(:each) do
    api_user_headers
  end
  context '#index' do
    it 'lists' do
      create(factory_key)
      process :index
      json = rest_response_body(:fabricators)
      expect(response.status).to eq(200)
      # Checks if serializer has attributes
      expect(json[0]).to include(:name)
      expect(json[0]).to include(:address)
      expect(json[0]).to include(:employee_qty)
    end
  end

  context '#show' do
    let(:fabricator) { create(factory_key) }
    it 'valid' do
      process :show, method: :get, params: {
        id: fabricator.id
      }
      json = rest_response_body(:fabricator)
      expect(response.status).to eq(200)
      expect(json[:id].to_i).to eq(fabricator.id)
      expect(json[:name]).to eq(fabricator.name)
      expect(json[:address]).to eq(fabricator.address)
      expect(json[:employee_qty]).to eq(fabricator.employee_qty)
    end
    it 'invalid' do
      process :show, method: :get, params: {
        id: fabricator.id + 2
      }
      expect(response.status).to eq(404)
      expect(response_body).to_not eq(nil)
    end
  end

  context '#create' do
    let(:fabricator) { build(:fabricator) }
    it 'valid' do
      process :create, method: :post, params: {
        fabricator: {
          name: fabricator.name,
          address: fabricator.address,
          employee_qty: fabricator.employee_qty
        }
      }
      json = rest_response_body(:fabricator)
      expect(response.status).to eq(201)
      expect(json).to include(:id)
      expect(json[:name]).to eq(fabricator.name)
      expect(json[:address]).to eq(fabricator.address)
      expect(json[:employee_qty]).to eq(fabricator.employee_qty)
    end

    it 'invalid' do
      process :create, method: :post, params: {
        fabricator: {
          name: fabricator.name
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#update' do
    let(:fabricator) { create(:fabricator) }
    it 'valid' do
      name = 'Updated name'
      process :update, method: :post, params: {
        id: fabricator.id,
        fabricator: {
          name: name
        }
      }
      json = rest_response_body(:fabricator)
      expect(response.status).to eq(200)
      expect(json[:name]).to eq(name)
    end

    it 'invalid' do
      process :update, method: :post, params: {
        id: fabricator.id,
        fabricator: {
          name: nil
        }
      }
      expect(response.status).to be(422)
    end
  end

  context '#destroy' do
    let(:fabricator) { create(factory_key) }
    it 'valid' do
      process :destroy, method: :post, params: {
        id: fabricator.id
      }
      expect(response.status).to eq(204)
      expect(rest_response_body(:fabricator)[:id].to_i).to eq(fabricator.id)
    end
  end
end
