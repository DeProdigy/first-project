class AddPlayerNamesToGamesTable < ActiveRecord::Migration
  def change
    add_column :games, :player_1_name, :string
    add_column :games, :player_2_name, :string
  end
end
