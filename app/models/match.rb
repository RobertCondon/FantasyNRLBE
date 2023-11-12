# == Schema Information
#
# Table name: matches
#
#  id             :bigint           not null, primary key
#  date           :datetime
#  round          :integer
#  score          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  away_roster_id :integer
#  home_roster_id :integer
#  winner_id      :bigint
#
class Match < ApplicationRecord
    belongs_to :away_roster, class_name: 'Roster', foreign_key: :away_roster_id
    belongs_to :home_roster, class_name: 'Roster', foreign_key: :home_roster_id
    belongs_to :winner, class_name: 'Team', foreign_key: :winner_id
end
