require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe GoalsController do
  describe 'Goals API', type: :request do
    before do
  	  @user = create(:user)
  	  @goal = create(:goal, user_id: @user.id)
  	  create(:key_result, user_id: @user.id, goal_id: @goal.id )

  	  headers       = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  	  @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, @user)
    end

    context 'get index' do
      it 'returns goals' do
        get '/goals', headers: @auth_headers
        json_response = JSON.parse(response.body)
      
        expect(response).to have_http_status(200)
        expect(json_response['data']).to be_present
        expect(json_response['message']).to eq('success')
        expect(json_response['data'].size).to eq(1)
      end
    end

    context 'post create' do
  	  before do
  	    post '/goals', headers: @auth_headers,
                       params:  { title:       'goal title', 
  	      					              start_date:  "#{Date.today}", 
  	      					              end_date:    "#{Date.tomorrow}" }.to_json
                       

        @json_response = JSON.parse(response.body)				     
  	  end

  	  it 'returns the title' do
  	    expect(@json_response['title']).to eq('goal title')
  	  end

  	  it 'returns the start_date' do
  	    expect(@json_response['start_date']).to eq("#{Date.today}")
  	  end

  	  it 'returns the end_date' do
  	    expect(@json_response['end_date']).to eq("#{Date.tomorrow}")
  	  end

  	  it 'returns the user' do
   	    expect(@json_response['user_id']).to eq(@user.id)
  	  end

  	  it 'returns success status code' do
   	    expect(response.status).to eq 201
  	  end
  	end

    context 'post create fails' do
  	  before do
  	    post '/goals', headers: @auth_headers,
                       params: { start_date: "#{Date.today}", 
  	      					             end_date: "#{Date.tomorrow}" }.to_json

        @json_response = JSON.parse(response.body)				     
  	  end

  	  it 'returns validation errors' do
  	    expect(@json_response).to eq({ 'title' => ["can't be blank"]})
  	  end

  	  it 'returns unprocessable_entity status code' do
   	    expect(response.status).to eq 422
  	  end
  	end

    context 'get show' do
      it 'returns goal' do
    	  create(:key_result, user_id: @user.id, goal_id: @goal.id, status: 'completed')

        get "/goals/#{@goal.id}", headers: @auth_headers
        json_response = JSON.parse(response.body)
      
        expect(response).to have_http_status(200)
        expect(json_response).to be_present
        expect(json_response['progress']).to eq('50 %')
        expect(json_response['start_date']).to eq("#{Date.today}")
        expect(json_response['end_date']).to eq("#{Date.tomorrow}")
        expect(@goal.key_results.size).to eq(2)
      end
    end

    let(:url) { '/users' }

    let(:params) do
      {
        user: {
          login: @user.email,
          password: @user.password
        }       
      }
    end

    let(:login_url) { '/users/sign_in' }

    let(:false_login_params) do
      {
        user: {
          login: @user.email,
          password: '123'
        }       
      }
    end

    context 'when params are correct' do
      before do
        post url, params: params.to_json, 
                  headers: { 'CONTENT_TYPE' => 'application/json', 
                             'ACCEPT' => 'application/json' }
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns JTW token in authorization header' do
        expect(response.headers['authorization']).to be_present
      end

      it 'returns valid JWT token' do
        token_from_request = response.headers['Authorization'].split(' ').last
        jwt_secret_key = Rails.application.credentials.devise[:jwt_secret_key]
        decoded_token = JWT.decode(token_from_request, jwt_secret_key, true)
        expect(decoded_token.first['sub']).to be_present
      end
    end

    context 'when login params are incorrect' do
      before { post login_url }
      
      it 'returns unathorized status' do
        expect(response.status).to eq 200
      end
    end
  end
end