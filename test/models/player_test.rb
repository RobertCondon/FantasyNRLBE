# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer
#
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
