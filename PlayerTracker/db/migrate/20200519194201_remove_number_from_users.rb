class RemoveNumberFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :number, :integer
    remove_column :users, :coach, :boolean
  end
end
