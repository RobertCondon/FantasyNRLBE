# == Schema Information
#
# Table name: matches
#
#  id           :bigint           not null, primary key
#  date         :datetime
#  round        :integer
#  score        :string
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  away_team_id :integer
#  home_team_id :integer
#  winner_id    :integer
#
# Indexes
#
#  index_matches_on_away_team_id  (away_team_id)
#  index_matches_on_home_team_id  (home_team_id)
#  index_matches_on_year          (year)
#
require "test_helper"

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
