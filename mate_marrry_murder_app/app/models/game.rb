# == Schema Information
#
# Table name: games
#
#  id            :integer          not null, primary key
#  player_1      :string(255)
#  player_2      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gender        :string(255)
#  player_1_name :string(255)
#  player_2_name :string(255)
#

class Game < ActiveRecord::Base
  attr_accessible :player_1, :player_2, :gender, :player_1_name, :player_2_name
  has_many :choices
  has_many :users, through: :choices
end
