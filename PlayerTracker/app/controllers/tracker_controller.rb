class TrackerController < ApplicationController
  def show
    @trackerArr = Tracker.where(player_id: params[:player_id], game_id: params[:game_id])
    @game = Game.find(params[:game_id])

    forwardPasses = @trackerArr.select {|tracker| tracker["y2"] < tracker["y1"]}
    backPasses = @trackerArr.select {|tracker| tracker["y2"] > tracker["y1"]}
    longPasses = @trackerArr.select {|tracker| distance(tracker) >= 159}
    medPasses = @trackerArr.select {|tracker| distance(tracker) < 159 && distance(tracker) > 60 }
    shortPasses = @trackerArr.select {|tracker| distance(tracker) <= 60 }
    completedPasses = @trackerArr.select {|tracker| tracker["complete"]}
    incompletePasses = @trackerArr.select {|tracker| !tracker["complete"]}

    @stats = [{name: "Forward Passes", data: forwardPasses}, {name: "Back Passes", data: backPasses}, {name: "Long Passes", data: longPasses}, 
      {name: "Medium Passes", data: medPasses}, {name: "Short Passes", data: shortPasses}, {name: "Completed Passes", data: completedPasses}, 
      {name: "Incomplete Passes", data: incompletePasses}]
  end
  
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

  private

  def distance(tracker)
    d = Math.sqrt((tracker["x2"] - tracker["x1"])**2 + (tracker["y2"] - tracker["y1"])**2)
  end
end
