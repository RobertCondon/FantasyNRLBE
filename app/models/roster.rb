# == Schema Information
#
# Table name: rosters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer
#  team_id    :bigint
#
class Roster < ApplicationRecord
  belongs_to :team
  belongs_to :player
  has_one :match
end
