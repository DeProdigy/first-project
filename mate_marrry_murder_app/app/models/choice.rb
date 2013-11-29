# == Schema Information
#
# Table name: choices
#
#  id         :integer          not null, primary key
#  given_1    :string(255)
#  answered_1 :string(255)
#  given_2    :string(255)
#  answered_2 :string(255)
#  given_3    :string(255)
#  answered_3 :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer
#

class Choice < ActiveRecord::Base
  attr_accessible :given_1, :answered_1, :given_2, :answered_2, :given_3, :answered_3, :user_id, :game_id
  belongs_to :user
  belongs_to :game
end
