class AddGenderToGames < ActiveRecord::Migration
  def change
    add_column :games, :gender, :string
  end
end
