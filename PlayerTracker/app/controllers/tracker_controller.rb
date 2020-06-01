class TrackerController < ApplicationController
  def track
    @player = Player.find(params[:player_id])
    @game = Game.find(params[:game_id])
  end

  def create
    @game = Game.find(params[:game_id])
    @player = Player.find(params[:player_id]) 
    trackerArr = params[:trackerArr]

    error = false

    allTrackers = Tracker.where(player_id: params[:player_id], game_id: params[:game_id])

    if allTrackers
      allTrackers.destroy_all
    end

    trackerArr.each do |indTrack|
      indTrack = indTrack[1]
      tracker = Tracker.create(x1: indTrack[:x1], y1: indTrack[:y1], x2: indTrack[:x2], y2: indTrack[:y2], 
        complete: indTrack[:complete], player_id: params[:player_id], game_id: params[:game_id])
      if !tracker.save
        error = true
        return
      end
    end


    if !error
      render :json => {"success": true}
    else
      render :json => {"success": false}
    end
  end
end
