require 'rails_helper'

RSpec.describe Api::PlayersController, type: :request do
  let!(:players) { create_list(:player, 10) }
  let(:player_id) { players.first.id }
  let(:valid_attributes) { { name: 'John Doe', position: 'Forward', team_id: create(:team).id } }

  describe 'GET /api/players' do
    before { get '/api/players' }

    it 'returns players' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'GET /api/players/:id' do
    before { get "/api/players/#{player_id}" }

    context 'when the record exists' do
      it 'returns the player' do
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(player_id)
      end
    end

    context 'when the record does not exist' do
      let(:player_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Player not found/)
      end
    end
  end

  describe 'POST /api/players' do
    context 'when the request is valid' do
      before { post '/api/players', params: valid_attributes }

      it 'creates a team' do
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['name']).to eq('John Doe')
      end
    end

    context 'when the request is invalid' do
      before { post '/api/players', params: { name: 'Foobar' } } # Assuming some attributes are missing

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
        expect(response.body).to match(/must exist/)
      end
    end
  end

  describe 'PUT /api/players/:id' do
    let(:valid_attributes) { { name: 'Updated Player' } }

    context 'when the record exists' do
      before { put "/api/players/#{player_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response).to have_http_status(200)
        updated_team = JSON.parse(response.body)
        expect(updated_team["name"]).to eq('Updated Player')
      end
    end
  end

  describe 'DELETE /api/players/:id' do
    before { delete "/api/players/#{player_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

