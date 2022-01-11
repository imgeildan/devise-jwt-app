RSpec.describe KeyResultsController do
  describe 'KeyResults API', type: :request do
    before do
  	  user = create(:user)
  	  @goal = create(:goal, user_id: user.id)
      create(:key_result, user_id: user.id, goal_id: @goal.id )

  	  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  	  @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
	  end

    context 'get index' do
      it 'returns key_results' do
        get '/key_results', headers: @auth_headers
        json_response = JSON.parse(response.body)
      
        expect(response).to have_http_status(200)
        expect(json_response).to be_present
      end
    end

    context 'post create' do
      before do
        post '/key_results', params: { title: 'key_result title', 
                                       goal_id: @goal.id }.to_json, headers: @auth_headers

        @json_response = JSON.parse(response.body)             
      end

      it 'returns the title' do
        expect(@json_response['title']).to eq('key_result title')
      end

      it 'returns the goal_id' do
        expect(@json_response['goal_id']).to eq(@goal.id)
      end

      it 'returns the status' do
        expect(@json_response['status']).to eq('not_started')
      end

      it 'returns the user' do
        expect(@json_response['user_id']).to eq(@goal.user_id)
      end
    end

    context 'post create fails' do
      before do
        post '/key_results', params: { status: 'in_progress', 
                                       goal_id: @goal.id }.to_json, headers: @auth_headers
          @json_response = JSON.parse(response.body)             
      end

      it 'returns validation errors' do
        expect(@json_response).to eq({ 'title' => ["can't be blank"]})
      end

      it 'returns unprocessable_entity status code' do
        expect(response.status).to eq 422
      end
    end
  end
end