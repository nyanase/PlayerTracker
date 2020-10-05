class CreateTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :trackers do |t|
      t.float :x1
      t.float :y1
      t.float :x2
      t.float :y2
      t.boolean :complete
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
