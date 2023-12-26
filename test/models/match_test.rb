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
# Indexes
#
#  index_matches_on_away_roster_id  (away_roster_id)
#  index_matches_on_home_roster_id  (home_roster_id)
#
require "test_helper"

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
