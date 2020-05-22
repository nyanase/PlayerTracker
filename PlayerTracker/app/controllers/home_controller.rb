class HomeController < ApplicationController
  def index
    if current_user
      @teams = Team.joins(:players).where("players.user_id = ?", current_user.id)
    end
  end
end
