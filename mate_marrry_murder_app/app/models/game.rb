class Game < ActiveRecord::Base
  attr_accessible :player_1, :player_2, :gender, :player_1_name, :player_2_name
  has_many :choices
  has_many :users, through: :choices
end