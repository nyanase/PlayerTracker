class Game < ApplicationRecord
  belongs_to :team
  has_many :trackers, dependent: :destroy
end
