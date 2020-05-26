class Team < ApplicationRecord
    has_many :players, dependent: :destroy
    has_many :games, dependent: :destroy

    validates :name, presence: true
    validates :name, uniqueness: true
end
