class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @team = Team.find(params[:team_id])

    @trackerArr = Tracker.where(player_id: params[:id])

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

  def new
    @player = Player.new
  end

  def create
  end

  private

  def distance(tracker)
    d = Math.sqrt((tracker["x2"] - tracker["x1"])**2 + (tracker["y2"] - tracker["y1"])**2)
  end
end
