class Game < ActiveRecord::Base
  attr_accessible :player_1, :player_2, :gender
end