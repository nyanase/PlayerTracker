class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.integer :number
      t.boolean :coach
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
