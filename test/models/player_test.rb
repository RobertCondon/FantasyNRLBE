# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  cost                   :integer
#  current_position       :string
#  fantasy_points_average :decimal(, )
#  fantasy_points_total   :integer
#  name                   :string
#  owned_by               :decimal(, )
#  position               :string
#  price                  :integer
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nrl_id                 :integer
#  team_id                :integer
#
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
