class Game < ApplicationRecord
  belongs_to :team
  has_many :trackers, dependent: :destroy

  validates :opponent, presence: true
  validates :date, presence: true
end
