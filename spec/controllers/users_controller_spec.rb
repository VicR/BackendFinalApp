require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'REST actions' do
    before(:each) do |example|
      api_user_headers unless example.metadata[:unauthorized]
    end
    context 'POST /sign_in' do
      let!(:user) { create(:user) }
      it 'should authenticate a valid user' do
        headers = api_user_login(user.email, user.password)
        response = rest_page_body(:user)

        # status code expectations
        expect(page.status_code).to eq(200)

        # header expectations
        expect(headers['access-token']).to be_present
        expect(headers['token-type']).to be_present
        expect(headers['client']).to be_present
        expect(headers['expiry']).to be_present
        expect(headers['uid']).to be_present

        # response expectations
        expect(response[:id]).to eq(user.id)
        expect(response[:name]).to eq(user.name)
        expect(response[:email]).to eq(user.email)
        expect(response[:profile]).to eq(user.profile)
      end
    end

    context 'GET /' do
      it 'should list all users' do
        create(:user)
        process :index
        json = rest_response_body(:users)
        expect(response.status).to eq(200)
        expect(json.length).to be > 0
      end

      it 'should return a 401', :unauthorized do
        create(:user)
        process :index
        expect(response.status).to eq(401)
      end
    end

    context 'GET /:id' do
      let(:user) { create(:user) }
      it 'should get an user' do
        process :show, method: :get, params: {
          id: user.id
        }
        json = rest_response_body(:user)
        expect(response.status).to eq(200)
        expect(json[:id]).to eq(user.id)
        expect(json[:name]).to eq(user.name)
        expect(json[:email]).to eq(user.email)
        expect(json[:profile]).to eq(user.profile)
      end

      it 'should return a 404' do
        process :show, method: :get, params: {
          id: user.id + 2
        }
        expect(response.status).to eq(404)
      end

      it 'should return a 401', :unauthorized do
        process :show, method: :get, params: {
          id: user.id
        }
        expect(response.status).to eq(401)
      end
    end

    context 'POST /' do
      let(:user) { build(:user) }
      it 'should create an User' do
        params = {
          user: {
            name: user.name,
            email: user.email,
            profile: user.profile,
            password: user.password,
            password_confirmation: user.password_confirmation
          }
        }
        page.driver.submit :post, '/admin_auth', params
        expect(page.status_code).to eq(201)
        json = rest_page_body(:user)
        expect(json[:id]).to_not be_nil
        expect(json[:name]).to eq(user.name)
        expect(json[:email]).to eq(user.email)
        expect(json[:profile]).to eq(user.profile)
      end
      it 'should not create an User' do
        params = {
          user: {
            name: user.name,
            password: user.password
          }
        }
        page.driver.submit :post, '/admin_auth', params
        expect(page.status_code).to eq(422)
      end
    end

    context 'GET /validate_token' do
      it 'should validate signed in user' do
        page.driver.submit :get, admin_auth_validate_token_url, {}
        json = rest_page_body(:user)
        expect(page.status_code).to eq(200)
        expect(json[:id]).to eq(@user.id)
        expect(json[:name]).to eq(@user.name)
        expect(json[:email]).to eq(@user.email)
        expect(json[:profile]).to eq(@user.profile)
      end
      it 'should reject invalid tokens' do
        page.driver.header('access-token', 'gibberish')
        page.driver.submit :get, admin_auth_validate_token_url, {}
        expect(page.status_code).to eq(401)
      end
    end

    context '#create' do
      before(:each) do
        api_user_headers
      end
      let(:user) { build(:user) }
      it 'valid' do
        process :create, method: :post, params: {
          user: {
            name: user.name,
            email: user.email,
            profile: user.profile,
            password: user.password
          }
        }
        json = rest_response_body(:user)
        expect(response.status).to eq(201)
        expect(json[:name]).to eq(user.name)
        expect(json[:email]).to eq(user.email)
        expect(json[:profile]).to eq(user.profile)
      end

      it 'invalid' do
        process :create, method: :post, params: {
          user: {
            name: user.name
          }
        }
        expect(response.status).to eq(422)
      end
    end

    context '#update' do
      let(:user) { create(:user) }
      it 'valid' do
        new_name = user.name + 'new_name'
        process :update, method: :post, params: {
          id: user.id,
          user: {
            name: new_name
          }
        }
        json = rest_response_body(:user)
        expect(response.status).to eq(200)
        expect(json[:name]).to eq(new_name)
      end

      it 'invalid' do
        process :update, method: :post, params: {
          id: user.id,
          user: {
            name: nil
          }
        }
        expect(response.status).to be(422)
      end

      it 'unauthorized', :unauthorized do
        new_name = user.name + 'new_name'
        process :update, method: :post, params: {
          id: user.id,
          user: {
            name: new_name
          }
        }
        expect(response.status).to eq(401)
      end
    end

    context '#destroy' do
      let(:user) { create(:user) }
      it 'valid' do
        process :destroy, method: :post, params: {
          id: user.id
        }
        expect(response.status).to eq(200)
        expect(rest_response_body(:user)[:id].to_i).to eq(user.id)
      end

      it 'unauthorized', :unauthorized do
        process :destroy, method: :post, params: {
          id: user.id
        }
        expect(response.status).to eq(401)
      end
    end
  end
end
