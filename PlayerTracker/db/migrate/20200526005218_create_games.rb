class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.date :date
      t.string :opponent
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
