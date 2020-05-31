class TrackerController < ApplicationController
  def track
    @player = Player.find(params[:player_id])
    @game = Game.find(params[:game_id])
  end

  def create
    
  end
end
