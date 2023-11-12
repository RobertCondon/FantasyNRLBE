# == Schema Information
#
# Table name: rosters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint
#
class Roster < ApplicationRecord
  belongs_to :team
end
