class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :destroy]

  def show
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

  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to team_setting_path(@player.team), notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def distance(tracker)
      d = Math.sqrt((tracker["x2"] - tracker["x1"])**2 + (tracker["y2"] - tracker["y1"])**2)
    end
end
