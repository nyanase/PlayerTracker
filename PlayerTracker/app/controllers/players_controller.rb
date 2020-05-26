class PlayersController < ApplicationController
  def show
  end

  def new
    @player = Player.new
  end

  def create
  end
end
