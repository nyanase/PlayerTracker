class Team < ApplicationRecord
    has_many :players, dependent: :destroy

    validates :name, presence: true
    validates :name, uniqueness: true
end
