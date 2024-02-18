require 'rails_helper'

RSpec.describe Api::TeamsController, type: :request do
  let!(:teams) { create_list(:team, 10) }
  let(:team_id) { teams.first.id }
  let(:valid_attributes) { { name: 'New Team', short_name: 'NT', ladder_position: 1, nrl_id: 123 } }

  describe 'GET /api/teams' do
    before { get '/api/teams' }

    it 'returns teams' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'GET /api/teams/:id' do
    before { get "/api/teams/#{team_id}" }

    context 'when the record exists' do
      it 'returns the team' do
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(team_id)
      end
    end

    context 'when the record does not exist' do
      let(:team_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Team not found/)
      end
    end
  end

  describe 'POST /api/teams' do
    context 'when the request is valid' do
      before { post '/api/teams', params: valid_attributes }

      it 'creates a team' do
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['name']).to eq('New Team')
      end
    end

    context 'when the request is invalid' do
      before { post '/api/teams', params: { name: 'Foobar' } } # Assuming some attributes are missing

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /api/teams/:id' do
    let(:valid_attributes) { { name: 'Updated Team' } }

    context 'when the record exists' do
      before { put "/api/teams/#{team_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response).to have_http_status(200)
        updated_team = JSON.parse(response.body)
        expect(updated_team["name"]).to eq('Updated Team')
      end
    end
  end

  describe 'DELETE /api/teams/:id' do
    before { delete "/api/teams/#{team_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

