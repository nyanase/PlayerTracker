class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    @team = Team.find(params[:team_id])
  end

  def create
    @team = Team.find(params[:team_id])
    @game = @team.games.create(game_params)
    respond_to do |format|
      if @game.save
        format.html { redirect_to team_path(@team) }
        format.json { render :show, status: :created, location: team_path(@team) }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end


  private 

  def game_params
    params.require(:game).permit(:date, :opponent)
  end
end
