class CreateChoicesTable < ActiveRecord::Migration
  def up
    create_table :choices do |t|
      t.string :given_1
      t.string :answered_1
      t.string :given_2
      t.string :answered_2
      t.string :given_3
      t.string :answered_3
      t.integer :user_id
      t.timestamps
    end
  end

  def down
  end
end
