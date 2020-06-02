class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy]

  def show
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

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to team_setting_path(@game.team), notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private 
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:date, :opponent)
    end
end
