class Choice < ActiveRecord::Base
  attr_accessible :given_1, :answered_1, :given_2, :answered_2, :given_3, :answered_3, :user_id, :game_id
end