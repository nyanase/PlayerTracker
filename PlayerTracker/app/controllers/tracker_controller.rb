class TrackerController < ApplicationController
  def track
    @player = Player.find(params[:player_id])
    @game = Game.find(params[:game_id])
  end

  def create
    puts "Player_id:"
    puts params[:player_id]
  end
end
