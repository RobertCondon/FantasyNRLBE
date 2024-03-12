# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  cost                   :integer
#  current_position       :string
#  fantasy_points_average :decimal(, )
#  fantasy_points_total   :integer
#  image_url              :string
#  name                   :string
#  owned_by               :decimal(, )
#  position               :string
#  price                  :integer
#  price_change           :integer
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nrl_id                 :integer
#  team_id                :integer
#
require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to(:team) }

  it "should have a valid factory" do
    expect(build(:player)).to be_valid
  end

  it 'runs populate_from_fantasy correctly' do
    players_json = {}
    player_processor = {}
    expect(Fetchers::NrlFantasy).to receive(:json).with("players").and_return(players_json)
    expect(Processors::Json::FantasyPlayer).to receive(:new).and_return(player_processor)
    expect(Importers::Interface).to receive(:import).with(data: players_json, processor: player_processor)
    Player.populate_from_fantasy
  end
end
