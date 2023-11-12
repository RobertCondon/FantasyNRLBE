# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :string
#  price      :integer
#  team       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Player < ApplicationRecord
  belongs_to :team
end
