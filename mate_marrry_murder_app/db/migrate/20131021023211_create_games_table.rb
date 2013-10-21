class CreateGamesTable < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.string :player_1
      t.string :player_2

      t.timestamps
    end
  end

  def down
  end
end
