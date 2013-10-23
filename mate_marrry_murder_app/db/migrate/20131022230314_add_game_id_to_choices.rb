class AddGameIdToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :game_id, :integer
  end
end
